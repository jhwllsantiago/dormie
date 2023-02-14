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

ActiveRecord::Schema[7.0].define(version: 2023_02_10_172140) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "address", default: "", null: false
    t.string "unit", default: "", null: false
    t.string "street", default: "", null: false
    t.string "barangay", default: "", null: false
    t.string "city", default: "", null: false
    t.string "query", default: "", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_locations_on_address"
    t.index ["latitude"], name: "index_locations_on_latitude"
    t.index ["longitude"], name: "index_locations_on_longitude"
    t.index ["owner_id"], name: "index_locations_on_owner_id"
  end

  create_table "occupants", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_occupants_on_confirmation_token", unique: true
    t.index ["email"], name: "index_occupants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_occupants_on_reset_password_token", unique: true
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "contact", default: "", null: false
    t.integer "status", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_owners_on_confirmation_token", unique: true
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", default: 5, null: false
    t.string "title", default: "", null: false
    t.text "comment", default: "", null: false
    t.bigint "room_id", null: false
    t.bigint "occupant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occupant_id"], name: "index_reviews_on_occupant_id"
    t.index ["room_id"], name: "index_reviews_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.float "rent", default: 0.0, null: false
    t.integer "capacity", default: 0, null: false
    t.integer "vacancies", default: 0, null: false
    t.string "tags", array: true
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_rooms_on_location_id"
    t.index ["name"], name: "index_rooms_on_name"
    t.index ["rent"], name: "index_rooms_on_rent"
    t.index ["tags"], name: "index_rooms_on_tags"
  end

  create_table "schedules", force: :cascade do |t|
    t.boolean "mon", array: true
    t.boolean "tue", array: true
    t.boolean "wed", array: true
    t.boolean "thu", array: true
    t.boolean "fri", array: true
    t.boolean "sat", array: true
    t.boolean "sun", array: true
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_schedules_on_owner_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "locations", "owners"
  add_foreign_key "reviews", "occupants"
  add_foreign_key "reviews", "rooms"
  add_foreign_key "rooms", "locations"
  add_foreign_key "schedules", "owners"
end
