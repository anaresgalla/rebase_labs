require 'rack/test'
require_relative '../server'

RSpec.describe 'Tests API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /tests' do
    it 'returns status code 200' do
      get '/tests'
      expect(last_response.status).to eq 200
    end

    it 'returns JSON content type' do
      get '/tests'
      expect(last_response.headers['Content-Type']).to eq 'application/json'
      expect { JSON.parse(last_response.body) }.not_to raise_error
    end

    it 'returns expected data' do
      get '/tests'
      data = JSON.parse(last_response.body)
      expect(data).to be_an(Array)  
      expect(data.any? { |item| item.key?('nome_paciente') && item.key?('cpf') }).to be true
    end
  end
end
