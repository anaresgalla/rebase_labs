# frozen_string_literal: true

require 'sidekiq'
require './services/db_service'

class ImportJob
  include Sidekiq::Job

  def perform(file)
    DbService.import_rows(file)
    File.delete(file)
  end
end
