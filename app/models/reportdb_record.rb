# frozen_string_literal: true
#  Coneect to the report database
class ReportdbRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :reportdb, reading: :reportdb }
end
