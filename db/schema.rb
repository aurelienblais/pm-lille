# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_08_210558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absence_types", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.decimal "leave_balance", default: "0.0"
    t.string "texture"
    t.boolean "display_statistic", default: true
  end

  create_table "absences", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "absence_type_id"
    t.string "date"
    t.index ["absence_type_id"], name: "index_absences_on_absence_type_id"
    t.index ["agent_id"], name: "index_absences_on_agent_id"
  end

  create_table "agents", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "register_number"
    t.date "birthday"
    t.date "arrival_date"
    t.date "departure_date"
    t.bigint "team_id"
    t.bigint "rank_id"
    t.integer "leave_balance", default: 35
    t.string "token"
    t.string "email"
    t.index ["rank_id"], name: "index_agents_on_rank_id"
    t.index ["team_id"], name: "index_agents_on_team_id"
  end

  create_table "compensatory_rests", force: :cascade do |t|
    t.bigint "agent_id"
    t.string "reason"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_compensatory_rests_on_agent_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.string "name"
  end

  create_table "recurring_absences", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "absence_type_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "periodicity"
    t.index ["absence_type_id"], name: "index_recurring_absences_on_absence_type_id"
    t.index ["agent_id"], name: "index_recurring_absences_on_agent_id"
  end

  create_table "room_messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_room_messages_on_room_id"
    t.index ["user_id"], name: "index_room_messages_on_user_id"
  end

  create_table "room_users", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.index ["room_id"], name: "index_room_users_on_room_id"
    t.index ["user_id"], name: "index_room_users_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "agent_id"
    t.index ["agent_id"], name: "index_rooms_on_agent_id"
    t.index ["name"], name: "index_rooms_on_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_teams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "role", default: "disabled", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
end
