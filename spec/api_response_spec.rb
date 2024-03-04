# frozen_string_literal: true

require 'rack/test'
require_relative '../server'

RSpec.describe 'Tests API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /tests' do
    it 'returns expected data' do
      get '/tests'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq 200
      expect(last_response.headers['Content-Type']).to eq 'application/json'
      expect(data).to be_an(Array)
      expect(data.any? { |item| item.key?('nome_paciente') && item.key?('cpf') && item.key?('id') }).to be true
      expect(data.any? { |item| item.value?('048.973.170-88') && item.value?('Emilly Batista Neto') }).to be true
    end
  end
end
