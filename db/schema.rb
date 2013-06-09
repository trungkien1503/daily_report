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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130609053829) do

  create_table "activations", :force => true do |t|
    t.integer  "user_id"
    t.string   "activation_status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "catalogs", :force => true do |t|
    t.string   "name"
    t.text     "document"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "catalogs", ["name"], :name => "index_catalogs_on_name", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "manager"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "reports", :force => true do |t|
    t.integer  "catalog_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "file"
  end

  add_index "reports", ["catalog_id"], :name => "index_reports_on_catalog_id"
  add_index "reports", ["user_id"], :name => "index_reports_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "password_digest"
    t.string   "activation_token"
    t.string   "remember_token"
    t.integer  "group_id"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["group_id"], :name => "index_users_on_group_id"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
