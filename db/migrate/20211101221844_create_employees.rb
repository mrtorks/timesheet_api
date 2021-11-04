class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :file_identifier
      t.date :date_worked
      t.string :employee_id
      t.string :job_group, default: 'A'
      t.integer :hourly_rate, default: 20
      t.integer :hours_worked
      t.integer :sub_total_pay, unique: true, default: nil
      t.string :pay_period, array: true, default: []
      t.timestamps
    end
  end
end
