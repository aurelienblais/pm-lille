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

ActiveRecord::Schema.define(version: 2020_09_17_191202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "absence_types", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "leave_balance", default: 0
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
    t.index ["rank_id"], name: "index_agents_on_rank_id"
    t.index ["team_id"], name: "index_agents_on_team_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.string "name"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "role", default: "user", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
