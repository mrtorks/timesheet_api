# frozen_string_literal: true

# "Blue print for returning json object of employee data"

class EmployeeBlueprint < Blueprinter::Base
  fields  :employee_id, :date_worked, :hours_worked, :job_group
end