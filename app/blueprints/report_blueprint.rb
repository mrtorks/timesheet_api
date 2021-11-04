# frozen_string_literal: true

# "Blueprint for report json object"

class ReportBlueprint < Blueprinter::Base
  field :employeeId
  field :payPeriod
  field :total_pay, name: :amountPaid
end
