# frozen_string_literal: true

require_relative '../services/test_service'

class TestsController
  def initialize(test_service)
    @test_service = test_service
  end

  def index
    @test_service.get_tests.to_json
  end
end
