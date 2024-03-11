# frozen_string_literal: true

require 'sinatra'
require_relative 'controllers/tests_controller'
require_relative 'services/test_service'

test_service = TestService.new('data.csv')
tests_controller = TestsController.new(test_service)

get '/exames' do
  headers 'Access-Control-Allow-Origin' => '*'
  content_type 'text/html'
  File.open('index.html')
end

get '/styles.css' do
  content_type 'text/css'
  File.read('styles.css')
end

get '/tests' do
  content_type :json
  tests_controller.index
end

get '/hello' do
  'Hello world!'
end

set :bind, '0.0.0.0'
set :port, 3000