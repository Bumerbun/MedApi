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

ActiveRecord::Schema[7.1].define(version: 2023_10_30_234603) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultation_requests", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.text "text", null: false
    t.datetime "created_at"
    t.index ["patient_id"], name: "index_consultation_requests_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "surname", limit: 100, null: false
    t.string "patronymic", limit: 100, null: false
    t.string "phone", limit: 12, null: false
    t.string "email", null: false
  end

  create_table "request_recommendations", force: :cascade do |t|
    t.bigint "consultation_request_id", null: false
    t.text "text", null: false
    t.index ["consultation_request_id"], name: "index_request_recommendations_on_consultation_request_id"
  end

  add_foreign_key "consultation_requests", "patients"
  add_foreign_key "request_recommendations", "consultation_requests"
end
