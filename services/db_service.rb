# frozen_string_literal: true

require 'pg'

class DbService
  DB_SETTINGS = { dbname: 'postgres', host: 'postgres', password: 'postgres', user: 'postgres' }
  # DB_SETTINGS tem config pra conexão com o db PostgreSQL

  # cria nova conexão com Postgres usando o q foi definido em DB_SETTINGS --> armazena a conexão na @conn
  def initialize
    @conn = PG.connect(DB_SETTINGS)
  end

  # recebe um [] de {} rows --> insere cada {} como uma linha na tabela tests do db
  def import_rows(rows)
    rows.each do |row|
      @conn.exec_params("INSERT INTO tests (cpf, nome_paciente, email_paciente, data_nascimento_paciente, 
      endereco_rua_paciente, cidade_paciente, estado_paciente, crm_medico, crm_medico_estado, nome_medico, 
      email_medico, token_resultado_exame, data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame) 
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
                [row['cpf'], row['nome_paciente'], row['email_paciente'], row['data_nascimento_paciente'], 
                row['endereco_rua_paciente'], row['cidade_paciente'], row['estado_paciente'], row['crm_medico'], 
                row['crm_medico_estado'], row['nome_medico'], row['email_medico'], row['token_resultado_exame'], 
                row['data_exame'], row['tipo_exame'], row['limites_tipo_exame'], row['resultado_tipo_exame']])
    
    # consulta SQL INSERT INTO --> insere uma nova linha na tab tests com os valores do hash atual
    # valores do {} --> array pro método exec_params --> substitui os marcadores de posição ($1...) na consulta SQL pelos valores correspondentes no []
    end
  end

  def close
    @conn.close
  end
end
