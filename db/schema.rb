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

ActiveRecord::Schema.define(version: 20160330201139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charges", force: :cascade do |t|
    t.string "charge_id"
    t.string "processor"
  end

  add_index "charges", ["charge_id"], name: "index_charges_on_charge_id", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "customer_id"
    t.string   "processor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id",     null: false
  end

  add_index "customers", ["customer_id"], name: "index_customers_on_customer_id", unique: true, using: :btree
  add_index "customers", ["user_id"], name: "index_customers_on_user_id", unique: true, using: :btree

  create_table "event_purchases", force: :cascade do |t|
    t.integer  "event_id",           null: false
    t.integer  "user_id",            null: false
    t.integer  "ticket_purchase_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "event_purchases", ["event_id", "user_id"], name: "index_event_purchases_on_event_id_and_user_id", unique: true, using: :btree
  add_index "event_purchases", ["event_id"], name: "index_event_purchases_on_event_id", using: :btree
  add_index "event_purchases", ["ticket_purchase_id"], name: "index_event_purchases_on_ticket_purchase_id", using: :btree
  add_index "event_purchases", ["user_id"], name: "index_event_purchases_on_user_id", using: :btree

  create_table "event_purchases_addon_purchases", id: false, force: :cascade do |t|
    t.integer "event_purchase_id",   null: false
    t.integer "product_purchase_id", null: false
  end

  add_index "event_purchases_addon_purchases", ["event_purchase_id", "product_purchase_id"], name: "index_event_purchases_addon_purchases", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",                                               null: false
    t.datetime "event_start"
    t.datetime "event_end"
    t.datetime "sale_start"
    t.datetime "sale_end"
    t.text     "description"
    t.string   "time_zone",   default: "Pacific Time (US & Canada)"
  end

  create_table "events_addons", id: false, force: :cascade do |t|
    t.integer "event_id",   null: false
    t.integer "product_id", null: false
  end

  add_index "events_addons", ["event_id", "product_id"], name: "index_events_addons_on_event_id_and_product_id", unique: true, using: :btree

  create_table "events_tickets", id: false, force: :cascade do |t|
    t.integer "event_id",   null: false
    t.integer "product_id", null: false
  end

  add_index "events_tickets", ["event_id", "product_id"], name: "index_events_tickets_on_event_id_and_product_id", unique: true, using: :btree

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.integer  "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "product_purchases", force: :cascade do |t|
    t.integer  "charge_id",  null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_purchases", ["charge_id"], name: "index_product_purchases_on_charge_id", using: :btree
  add_index "product_purchases", ["product_id"], name: "index_product_purchases_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "USD", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "first_name", default: "",    null: false
    t.string   "last_name",  default: "",    null: false
    t.string   "email",      default: "",    null: false
    t.boolean  "admin",      default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "customers", "users"
  add_foreign_key "event_purchases", "events"
  add_foreign_key "event_purchases", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "product_purchases", "charges"
  add_foreign_key "product_purchases", "products"
end
