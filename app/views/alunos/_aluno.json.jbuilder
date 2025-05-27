json.extract! aluno, :id, :nome, :nacionalidade, :municipio_nascimento, :uf_nascimento, :data_nascimento, :sexo, :cor_raca, :nome_mae, :cpf_mae, :rg_mae, :funcao_mae, :nome_pai, :cpf_pai, :rg_pai, :funcao_pai, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
