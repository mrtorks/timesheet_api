class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :employeeId
      t.string :job_group
      t.date :startDate
      t.date :endDate
      t.jsonb :payPeriod
      t.string :total_pay
      t.timestamps
    end
  end
end
