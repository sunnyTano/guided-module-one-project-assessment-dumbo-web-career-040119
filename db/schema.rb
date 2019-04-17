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

ActiveRecord::Schema.define(version: 2019_04_16_144518) do

  create_table "bookings", force: :cascade do |t|
    t.string "checkin_date"
    t.string "checkout_date"
    t.integer "guest_id"
    t.integer "room_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "username"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_type"
    t.integer "capacity"
  end

end
