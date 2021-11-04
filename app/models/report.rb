# frozen_string_literal: true

# "Write employee report"
class Report < ReportdbRecord
  # generate the report
  def develop_report
    report_hash =
      Employee.group(:employee_id, :pay_period, :job_group).sum(:sub_total_pay)
    report_hash.each do |key, value|
      create_report(
        key[0],
        key[1][0].to_date,
        key[1][1].to_date,
        key[2],
        value
      )
    end
  end

  # save report to database
  def create_report(
    employee_id,
    start_date,
    end_date,
    job_group,
    pending_subtotal_pay
  )
    report = Report.new
    report.employeeId = employee_id
    report.job_group = job_group
    report.startDate = start_date
    report.endDate = end_date
    report.payPeriod = { startDate: start_date, endDate: end_date }
    report.total_pay = "$#{pending_subtotal_pay}.00"
    report.save!
  end
end
