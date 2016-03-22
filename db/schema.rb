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

ActiveRecord::Schema.define(version: 20160322181348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.datetime "event_start"
    t.datetime "event_end"
    t.datetime "sale_start"
    t.datetime "sale_end"
  end

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.integer  "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "ticket_purchases", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ticket_purchases", ["event_id"], name: "index_ticket_purchases_on_event_id", using: :btree
  add_index "ticket_purchases", ["ticket_id"], name: "index_ticket_purchases_on_ticket_id", using: :btree
  add_index "ticket_purchases", ["user_id"], name: "index_ticket_purchases_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "first_name", default: "",    null: false
    t.string   "last_name",  default: "",    null: false
    t.string   "email",      default: "",    null: false
    t.boolean  "admin",      default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "ticket_purchases", "tickets"
  add_foreign_key "ticket_purchases", "users"
  add_foreign_key "tickets", "events"
end
