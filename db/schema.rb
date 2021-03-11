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

ActiveRecord::Schema.define(version: 2021_02_25_015520) do

  create_table "bookings", charset: "utf8mb4", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "status", default: 0
    t.integer "deleted", default: 0
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "customers", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "id_card"
    t.date "birthday"
    t.string "address"
    t.integer "deleted", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "room_types", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.integer "deleted", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "image"
    t.integer "deleted", default: 0
    t.integer "status", default: 0
    t.string "description"
    t.bigint "room_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "id_card"
    t.date "birthday"
    t.integer "deleted", default: 0
    t.integer "role", default: 0
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "rooms", "room_types"
end
