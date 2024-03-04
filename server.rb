require 'sinatra'
require 'pg'
require 'json'

DB_SETTINGS = { dbname: 'postgres', host: 'postgres', password: 'postgres', user: 'postgres' }

def db_connection
  PG.connect(DB_SETTINGS)
end

get '/tests' do
  conn = db_connection
  rows = conn.exec('SELECT * FROM tests;')
  conn.close

  content_type :json
  rows.map { |row| row.to_h }.to_json
end

get '/hello' do
  'Hello world!'
end

set :bind, '0.0.0.0'
set :port, 3000
