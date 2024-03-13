# frozen_string_literal: true

require 'csv'

# get_tests lê o arq CSV, retorna um array de hashes
# search que procura pelo token
class TestService
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @tests = nil
  end

  def get_tests
    if @tests.nil?
      @tests = {}
      CSV.read(@csv_file_path, headers: true, col_sep: ';').each do |row|
        token = row['token resultado exame']
        # ||= memoize: se não estiver preenchido, preenche
        @tests[token] ||= {
          "cpf" => row['cpf'],
          "nome paciente" => row['nome paciente'],
          "email paciente" => row['email paciente'],
          "data nascimento paciente" => row['data nascimento paciente'],
          "endereço/rua paciente" => row['endereço/rua paciente'],
          "cidade paciente" => row['cidade paciente'],
          "estado paciente" => row['estado patiente'],
          "crm médico" => row['crm médico'],
          "crm médico estado" => row['crm médico estado'],
          "nome médico" => row['nome médico'],
          "email médico" => row['email médico'],
          "token resultado exame" => token,
          "data exame" => row['data exame'],
          "exames" => []
        }

        @tests[token]["exames"] << {
          "token resultado exame" => token,
          "data exame" => row['data exame'],
          "tipo exame" => row['tipo exame'],
          "limites tipo exame" => row['limites tipo exame'],
          "resultado tipo exame" => row['resultado tipo exame']
        }
      end

      @tests = @tests.values
    end
    @tests
  end

  def search(token)
    get_tests.each do |test|      
      if test["token resultado exame"] == token
        return test
      end
    end
    nil
  end
end
