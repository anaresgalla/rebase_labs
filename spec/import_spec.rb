require_relative '../server'
require 'rack/test'
require 'pg'
require 'rspec/mocks'

RSpec.describe 'Importa dados CSV por API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'com sucesso' do
    data = 'spec/assets/data.csv'

    conn = double('PG Connection')
    allow(PG).to receive(:connect).and_return(conn)
    allow(conn).to receive(:exec)

    post '/import', file: Rack::Test::UploadedFile.new(data, 'text/csv')

    expect(last_response).to be_ok
  end
end
