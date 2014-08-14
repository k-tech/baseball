desc "import csv data to database"
task import: :environment do
  require 'services/import_service'
  ImportService.import_to_db
end
