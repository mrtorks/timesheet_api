# frozen_string_literal: true

module Api
  module V1
    # "Controller for returning the report"
    # show,update and destroy have been deleted to shed light on crtitcal method and to satisfy api requirements
    class ReportsController < ApplicationController
      # GET report

      def index
        @report = Report.all
        render json: { payrollReport: ReportBlueprint.render_as_hash(@report, root: :employeeReports) }
      end
    end
  end
end
