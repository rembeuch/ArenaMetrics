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

ActiveRecord::Schema[7.1].define(version: 2024_04_13_093654) do
  create_table "reservations", force: :cascade do |t|
    t.string "ticket_number"
    t.string "reservation_number"
    t.date "reservation_date"
    t.time "reservation_time"
    t.string "show_key"
    t.string "show_name"
    t.string "representation_key"
    t.string "representation_name"
    t.date "representation_date"
    t.time "representation_start_time"
    t.date "representation_end_date"
    t.time "representation_end_time"
    t.decimal "price"
    t.string "product_type"
    t.string "sales_channel"
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "address"
    t.string "postal_code"
    t.string "country"
    t.integer "age"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
