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

ActiveRecord::Schema.define(version: 2018_04_16_222514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animais", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "nome_cientifico"
    t.text "observacao"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["slug"], name: "index_animais_on_slug", unique: true
    t.index ["usuario_id"], name: "index_animais_on_usuario_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "titulo"
    t.string "slug"
    t.text "texto"
    t.bigint "usuario_id"
    t.bigint "local_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_blogs_on_local_id"
    t.index ["usuario_id"], name: "index_blogs_on_usuario_id"
  end

  create_table "comentarios", force: :cascade do |t|
    t.string "texto"
    t.string "slug"
    t.bigint "experiencia_agroecologica_id"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experiencia_agroecologica_id"], name: "index_comentarios_on_experiencia_agroecologica_id"
    t.index ["usuario_id"], name: "index_comentarios_on_usuario_id"
  end

  create_table "experiencia_agroecologicas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.bigint "usuario_id"
    t.bigint "local_id"
    t.bigint "tema_experiencia_agroecologica_id"
    t.text "resumo"
    t.text "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_experiencia_agroecologicas_on_local_id"
    t.index ["slug"], name: "index_experiencia_agroecologicas_on_slug", unique: true
    t.index ["tema_experiencia_agroecologica_id"], name: "idx_exp_agroecologicas_on_tema_exp_agroecologica_id"
    t.index ["usuario_id"], name: "index_experiencia_agroecologicas_on_usuario_id"
  end

  create_table "locais", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "observacao"
    t.float "latitude"
    t.float "longitude"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.string "tipo"
    t.string "hospedagem"
    t.index ["slug"], name: "index_locais_on_slug", unique: true
    t.index ["usuario_id"], name: "index_locais_on_usuario_id"
  end

  create_table "local_usuarios", force: :cascade do |t|
    t.bigint "local_id"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_local_usuarios_on_local_id"
    t.index ["usuario_id"], name: "index_local_usuarios_on_usuario_id"
  end

  create_table "midias", force: :cascade do |t|
    t.string "descricao"
    t.string "slug"
    t.bigint "saf_id"
    t.bigint "experiencia_agroecologica_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.bigint "usuario_id"
    t.index ["experiencia_agroecologica_id"], name: "index_midias_on_experiencia_agroecologica_id"
    t.index ["saf_id"], name: "index_midias_on_saf_id"
    t.index ["slug"], name: "index_midias_on_slug", unique: true
    t.index ["usuario_id"], name: "index_midias_on_usuario_id"
  end

  create_table "organizacao_locais", force: :cascade do |t|
    t.bigint "organizacao_id"
    t.bigint "local_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_organizacao_locais_on_local_id"
    t.index ["organizacao_id"], name: "index_organizacao_locais_on_organizacao_id"
  end

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

  create_table "plantas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "nome_cientifico"
    t.text "observacao"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["slug"], name: "index_plantas_on_slug", unique: true
    t.index ["usuario_id"], name: "index_plantas_on_usuario_id"
  end

  create_table "saf_animais", force: :cascade do |t|
    t.bigint "saf_id"
    t.bigint "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_saf_animais_on_animal_id"
    t.index ["saf_id"], name: "index_saf_animais_on_saf_id"
  end

  create_table "saf_plantas", force: :cascade do |t|
    t.bigint "saf_id"
    t.bigint "planta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planta_id"], name: "index_saf_plantas_on_planta_id"
    t.index ["saf_id"], name: "index_saf_plantas_on_saf_id"
  end

  create_table "safs", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.string "objetivo"
    t.string "produto_principal"
    t.date "inicio"
    t.date "fim"
    t.string "area"
    t.bigint "local_id"
    t.bigint "usuario_id"
    t.text "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_safs_on_local_id"
    t.index ["slug"], name: "index_safs_on_slug", unique: true
    t.index ["usuario_id"], name: "index_safs_on_usuario_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tema_experiencia_agroecologicas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tema_experiencia_agroecologicas_on_slug", unique: true
    t.index ["usuario_id"], name: "index_tema_experiencia_agroecologicas_on_usuario_id"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "nome"
    t.string "slug"
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.bigint "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_usuarios_on_slug", unique: true
  end

  add_foreign_key "animais", "usuarios"
  add_foreign_key "blogs", "locais"
  add_foreign_key "blogs", "usuarios"
  add_foreign_key "comentarios", "experiencia_agroecologicas"
  add_foreign_key "comentarios", "usuarios"
  add_foreign_key "experiencia_agroecologicas", "locais"
  add_foreign_key "experiencia_agroecologicas", "tema_experiencia_agroecologicas"
  add_foreign_key "experiencia_agroecologicas", "usuarios"
  add_foreign_key "locais", "usuarios"
  add_foreign_key "local_usuarios", "locais"
  add_foreign_key "local_usuarios", "usuarios"
  add_foreign_key "midias", "experiencia_agroecologicas"
  add_foreign_key "midias", "safs"
  add_foreign_key "midias", "usuarios"
  add_foreign_key "organizacao_locais", "locais"
  add_foreign_key "organizacao_locais", "organizacoes"
  add_foreign_key "organizacoes", "tipo_organizacoes"
  add_foreign_key "organizacoes", "usuarios"
  add_foreign_key "plantas", "usuarios"
  add_foreign_key "saf_animais", "animais"
  add_foreign_key "saf_animais", "safs"
  add_foreign_key "saf_plantas", "plantas"
  add_foreign_key "saf_plantas", "safs"
  add_foreign_key "safs", "locais"
  add_foreign_key "safs", "usuarios"
  add_foreign_key "tema_experiencia_agroecologicas", "usuarios"
  add_foreign_key "tipo_organizacoes", "usuarios"
end
