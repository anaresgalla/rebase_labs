# frozen_string_literal: true

class Test
  attr_reader :cpf, :nome_paciente, :email_paciente, :data_nascimento_paciente, :endereco_rua_paciente, 
              :cidade_paciente, :estado_paciente, :crm_medico, :crm_medico_estado, :nome_medico, 
              :email_medico, :token_resultado_exame, :data_exame, :tipo_exame, :limites_tipo_exame, :resultado_tipo_exame

  def initialize(attributes)
    @cpf = attributes['cpf']
    @nome_paciente = attributes['nome_paciente']
    @email_paciente = attributes['email_paciente']
    @data_nascimento_paciente = attributes['data_nascimento_paciente']
    @endereco_rua_paciente = attributes['endereco_rua_paciente']
    @cidade_paciente = attributes['cidade_paciente']
    @estado_paciente = attributes['estado_paciente']
    @crm_medico = attributes['crm_medico']
    @crm_medico_estado = attributes['crm_medico_estado']
    @nome_medico = attributes['nome_medico']
    @email_medico = attributes['email_medico']
    @token_resultado_exame = attributes['token_resultado_exame']
    @data_exame = attributes['data_exame']
    @tipo_exame = attributes['tipo_exame']
    @limites_tipo_exame = attributes['limites_tipo_exame']
    @resultado_tipo_exame = attributes['resultado_tipo_exame']
  end
end
