# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170805185546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizacoes", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "sigla"
    t.bigint "tipo_organizacao_id"
    t.string "email"
    t.string "telefone"
    t.string "site"
    t.text "descricao"
    t.string "cidade"
    t.string "uf"
    t.string "pais"
    t.float "latitude"
    t.float "longitude"
    t.string "observacao"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_organizacoes_on_email", unique: true
    t.index ["slug"], name: "index_organizacoes_on_slug", unique: true
    t.index ["tipo_organizacao_id"], name: "index_organizacoes_on_tipo_organizacao_id"
    t.index ["usuario_id"], name: "index_organizacoes_on_usuario_id"
  end

  create_table "tipo_organizacoes", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tipo_organizacoes_on_slug", unique: true
    t.index ["usuario_id"], name: "index_tipo_organizacoes_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "nome"
    t.string "slug"
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.integer "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_usuarios_on_slug", unique: true
  end

  add_foreign_key "organizacoes", "tipo_organizacoes"
  add_foreign_key "organizacoes", "usuarios"
  add_foreign_key "tipo_organizacoes", "usuarios"
end
