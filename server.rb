# frozen_string_literal: true

require 'sinatra'
require 'pg'
require 'json'

DB_SETTINGS = { dbname: 'postgres', host: 'postgres', password: 'postgres', user: 'postgres' }.freeze

def db_connection
  PG.connect(DB_SETTINGS)
end

get '/tests' do
  conn = db_connection
  rows = conn.exec('SELECT * FROM tests;')
  conn.close

  content_type :json
  rows.map(&:to_h).to_json
end

get '/' do
  'Hello world!'
end

set :bind, '0.0.0.0'
set :port, 3000
