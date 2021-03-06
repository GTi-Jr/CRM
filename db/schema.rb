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

ActiveRecord::Schema.define(version: 20140707043839) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "date_begin"
    t.datetime "date_limit"
    t.datetime "date_reminder"
    t.string   "priority"
    t.string   "status"
    t.string   "visibility"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "website"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "occupation"
    t.string   "linkedin"
    t.string   "website"
    t.text     "background"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "emails", force: true do |t|
    t.text     "message"
    t.string   "date_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "subject"
    t.string   "sender"
    t.string   "visibility"
  end

  create_table "projects", force: true do |t|
    t.string   "token"
    t.datetime "date_begin"
    t.datetime "date_limit"
    t.datetime "date_estimated"
    t.string   "status"
    t.integer  "percent"
    t.string   "category"
    t.string   "priority"
    t.float    "revenue"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "visibility"
    t.string   "title"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "occupation"
    t.string   "phone"
    t.string   "linkedin"
    t.string   "website"
    t.text     "background"
    t.string   "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tour"
  end

end
