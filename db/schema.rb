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

ActiveRecord::Schema[8.0].define(version: 2025_05_30_143431) do
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

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "series"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_enrollments_on_classroom_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "cpf"
    t.string "rg"
    t.string "nationality"
    t.string "gender"
    t.string "race"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "father_name"
    t.string "father_name_cpf"
    t.string "mother_name"
    t.string "mother_name_cpf"
    t.boolean "has_family_allowance"
    t.boolean "has_disability"
    t.boolean "requires_religious_education_exemption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "student_id", null: false
    t.string "school_destination"
    t.date "transfer_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_transfers_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "secretaria"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "enrollments", "classrooms"
  add_foreign_key "enrollments", "students"
  add_foreign_key "sessions", "users"
  add_foreign_key "transfers", "students"
end
