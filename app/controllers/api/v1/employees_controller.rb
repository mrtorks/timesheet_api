# frozen_string_literal: true

module Api
  module V1
    # "Controller for uploading and generating the report"
    # show,update,private methods for action and destroy have been deleted to shed light on crtitcal method as well as satisfy api requirements
    class EmployeesController < ApplicationController
      # GET /employees
      def index
        @employees = Employee.all
        render json: EmployeeBlueprint.render(@employees)
      end

      # POST /employees

      def create
        @employee = Employee.import_upload(params[:file])
        @report = Report.new.develop_report 
        render json: EmployeeBlueprint.render(Employee.all), status: :created, message: 'Successfully created'
      rescue Employee::DuplicateError => e
        render json: e.message, status: :unprocessable_entity
      end
    end
  end
end
