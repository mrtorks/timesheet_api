# frozen_string_literal: true

# "Import and store empoloyee relevant data"
class Employee < ApplicationRecord
  require 'csv'
  require 'digest/md5'
  require 'date'

  # prevent duplicate file uploads
  class DuplicateError < StandardError
    def message
      'Duplicate Error'
    end
  end

  # Calculate amount owed to employee based on job group
  class GeneratePay < Employee
    def sub_total_pay(hours, job_group)
      return hours * 30 if job_group == 'B'

      hours * 20
    end
  end

  # Determine the pay period based on the date worked.
  # Credit https://stackoverflow.com/a/51916771
  class GeneratePayPeriod < Employee
    require 'date'

    def pay_period_range(date)
      days_in_a_month = Time.days_in_month(date.month, date.year)

      # this will round down. 30/31-day months will output 15. 28 / 29-day will output 14. Adjust as per your requirements
      middle_day = days_in_a_month / 2
      if date.day <= middle_day
        [date.beginning_of_month, date.change(day: middle_day)]
      else
        [date.change(day: middle_day + 1), date.end_of_month]
      end
    end
  end

  # Import CSV data
  def self.import_upload(file)
    file_hash = Digest::MD5.hexdigest(File.read(file))
    raise DuplicateError if check_duplicate(file_hash)

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      employee_id = row.to_hash[:employee_id]
      job_group = row.to_hash[:job_group]
      alt_rate = 30
      hours_worked = row.to_hash[:hours_worked].to_i
      date = Date.strptime(row.to_hash[:date], '%d/%m/%Y')
      pay_period = GeneratePayPeriod.new.pay_period_range(date)
      sub_total_pay = GeneratePay.new.sub_total_pay(hours_worked, job_group)
      create_employee(
        employee_id,
        job_group,
        alt_rate,
        hours_worked,
        pay_period,
        sub_total_pay,
        file_hash,
        date
      )
    end
  end

  def self.check_duplicate(file_hash)
    return true if Employee.exists?(file_identifier: file_hash)
  end

  def self.create_employee(
    employee_id,
    job_group,
    alt_rate,
    hours_worked,
    pay_period,
    sub_total_pay,
    file_hash,
    date
  )
    employee = Employee.new
    employee.employee_id = employee_id
    employee.job_group = job_group
    employee.hourly_rate = alt_rate if job_group != 'A'
    employee.hours_worked = hours_worked
    employee.pay_period = pay_period
    employee.sub_total_pay = sub_total_pay
    employee.file_identifier = file_hash
    employee.date_worked = date
    employee.save
  end
end
