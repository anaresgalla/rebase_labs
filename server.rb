# frozen_string_literal: true
# script Ruby --> configura e inicia um servidor web usando Sinatra

require 'sinatra'
require_relative 'controllers/tests_controller'
require_relative 'services/test_service'
require_relative 'import_job'

test_service = TestService.new('data.csv')
tests_controller = TestsController.new(test_service)

get '/exames' do
  headers 'Access-Control-Allow-Origin' => '*' # --> qualquer site pode fazer requisições para a rota
  content_type 'text/html'
  erb :index
end

get '/styles.css' do
  content_type 'text/css'
  File.read('styles.css')
end

get '/tests' do
  content_type :json
  tests_controller.index # -->  resposta através do método index do tests_controller
end

get '/tests/:token' do
  content_type :json
  exam = tests_controller.search(params[:token])

  if exam
    exam.to_json
  else
    status 404
    { error: 'Exame não encontrado' }.to_json
  end
end

post '/import' do
  if params['file'] && (params['file']['type'] == 'text/csv')
    
    file = params[:file][:tempfile]
    csv_content = CSV.read(file, headers: true, col_sep: ';')

    CSV.open('data/new_data.csv', 'w', col_sep: ';') do |csv|
      csv << csv_content.headers

      csv_content.each do |row|
        csv << row
      end
    end
    file_path = 'data/new_data.csv'

    ImportJob.perform_async(file_path)
    @message = 'Importação realizada com sucesso'

  else
    @message = 'Erro: Arquivo inválido'
  end

  ImportJob.perform_async
  erb :index
end

get '/hello' do
  'Hello world!'
end

set :bind, '0.0.0.0'
set :port, 3000
# servidor escuta todas as interfaces de rede 0.0.0.0 na porta 3000
