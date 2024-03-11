# frozen_string_literal: true

require_relative 'services/csv_service'
require_relative 'services/db_service'

csv_service = CsvService.new('data.csv')
db_service = DbService.new

rows = csv_service.read_csv
db_service.import_rows(rows)
db_service.close
