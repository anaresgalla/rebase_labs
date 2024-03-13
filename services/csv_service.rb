# frozen_string_literal: true

require 'csv'

# file_path = caminho pro arq CSV que vai ser lido --> armazenado na var de inst @file_path
class CsvService
  def initialize(file_path)
    @file_path = file_path
  end

  # lê o arquivo CSV --> retorna dados em um array de hashes
  def read_csv
    rows = CSV.read(@file_path, col_sep: ';')
    columns = rows.shift # remove e retorna o 1º elem do array rows com nomes das colunas do CSV

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx| #  inicia outro loop q itera sobre cada cél na linha --> cria novo hash vazio [acc] e mantém o índice
        column = columns[idx]
        acc[column] = cell
        # nome da col da cél atual e add key-value ao {acc} --> key: nome da coluna, value: valor da célula
      end
    end
  end
end
