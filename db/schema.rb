# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130926030731) do

  create_table "albums", force: true do |t|
    t.string   "nome"
    t.integer  "usuario_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["usuario_id"], name: "albums_usuario_id_fk", using: :btree

  create_table "comentarios", force: true do |t|
    t.string   "comentario"
    t.integer  "usuario_id", null: false
    t.integer  "imagem_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentarios", ["imagem_id"], name: "comentarios_imagem_id_fk", using: :btree
  add_index "comentarios", ["usuario_id"], name: "comentarios_usuario_id_fk", using: :btree

  create_table "friendships", force: true do |t|
    t.integer "friendable_id"
    t.integer "friend_id"
    t.integer "blocker_id"
    t.boolean "pending",       default: true
  end

  add_index "friendships", ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true, using: :btree

  create_table "imagems", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagem_file_name"
    t.string   "imagem_content_type"
    t.integer  "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.integer  "album_id"
  end

  add_index "imagems", ["album_id"], name: "imagems_album_id_fk", using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "informacoesPessoais"
    t.string   "atalho"
    t.integer  "imagem_avatar_id"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "albums", "usuarios", name: "albums_usuario_id_fk"

  add_foreign_key "comentarios", "imagems", name: "comentarios_imagem_id_fk"
  add_foreign_key "comentarios", "usuarios", name: "comentarios_usuario_id_fk"

  add_foreign_key "imagems", "albums", name: "imagems_album_id_fk"

end
