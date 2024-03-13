# frozen_string_literal: true
# script Ruby --> configura e inicia um servidor web usando Sinatra

require 'sinatra'
require_relative 'controllers/tests_controller'
require_relative 'services/test_service'

test_service = TestService.new('data.csv')
tests_controller = TestsController.new(test_service)

get '/exames' do
  headers 'Access-Control-Allow-Origin' => '*' # --> qualquer site pode fazer requisições para a rota
  content_type 'text/html'
  File.open('index.html')
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

get '/hello' do
  'Hello world!'
end

set :bind, '0.0.0.0'
set :port, 3000
# servidor escuta todas as interfaces de rede 0.0.0.0 na porta 3000
