require 'csv'
require 'pg'

DB_SETTINGS = { dbname: 'postgres', host: 'postgres', password: 'postgres', user: 'postgres' }

def db_connection
  PG.connect(DB_SETTINGS)
end

def create_table(conn)
  conn.exec("CREATE TABLE IF NOT EXISTS tests (
            id SERIAL,
            cpf VARCHAR,
            nome_paciente VARCHAR,
            email_paciente VARCHAR,
            data_nascimento_paciente DATE,
            endereco_rua_paciente VARCHAR,
            cidade_paciente VARCHAR,
            estado_paciente VARCHAR,
            crm_medico VARCHAR,
            crm_medico_estado VARCHAR,
            nome_medico VARCHAR,
            email_medico VARCHAR,
            token_resultado_exame VARCHAR,
            data_exame DATE,
            tipo_exame VARCHAR,
            limites_tipo_exame VARCHAR,
            resultado_tipo_exame VARCHAR
          );")
end

def import_data(conn)
  CSV.foreach("./data.csv", col_sep: ';', headers: true) do |row|
    conn.exec_params("INSERT INTO tests (cpf, nome_paciente, email_paciente, data_nascimento_paciente, 
                                         endereco_rua_paciente, cidade_paciente, estado_paciente, crm_medico, 
                                         crm_medico_estado, nome_medico, email_medico, token_resultado_exame, 
                                         data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame) 
                                         VALUES ($1, $2, $3, $4, $5, $6, 
                                                 $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
                                         row.fields)
  end
end

conn = db_connection
create_table(conn)
import_data(conn)
puts 'A importação foi concluída com sucesso'
conn.close
