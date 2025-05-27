# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_24_020556) do
  create_table "alunos", force: :cascade do |t|
    t.string "nome"
    t.string "nacionalidade"
    t.string "municipio_nascimento"
    t.string "uf_nascimento"
    t.date "data_nascimento"
    t.string "sexo"
    t.string "cor_raca"
    t.string "nome_mae"
    t.string "cpf_mae"
    t.string "rg_mae"
    t.string "funcao_mae"
    t.string "nome_pai"
    t.string "cpf_pai"
    t.string "rg_pai"
    t.string "funcao_pai"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
