# frozen_string_literal: true

require 'csv'

class CsvService
  def initialize(file_path)
    @file_path = file_path
  end

  def read_csv
    rows = CSV.read(@file_path, col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end
end
