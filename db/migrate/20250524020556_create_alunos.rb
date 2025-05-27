class CreateAlunos < ActiveRecord::Migration[8.0]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :nacionalidade
      t.string :municipio_nascimento
      t.string :uf_nascimento
      t.date :data_nascimento
      t.string :sexo
      t.string :cor_raca
      t.string :nome_mae
      t.string :cpf_mae
      t.string :rg_mae
      t.string :funcao_mae
      t.string :nome_pai
      t.string :cpf_pai
      t.string :rg_pai
      t.string :funcao_pai

      t.timestamps
    end
  end
end
