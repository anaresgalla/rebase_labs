# frozen_string_literal: true

require_relative '../services/test_service'

# classe que lida com requisições HTTP relacionadas a tests
class TestsController
  def initialize(test_service)
    @test_service = test_service
  end

  # chama o método get_tests na var. de instância @test_service, converte para JSON --> responde a GET /tests
  def index 
    @test_service.get_tests.to_json
  end

  # responde requisições GET /tests/:token
  def search(token) 
    @test_service.search(token)
  end 
end
