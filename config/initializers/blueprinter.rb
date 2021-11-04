require 'oj'

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
  config.sort_fields_by = :definition
end
