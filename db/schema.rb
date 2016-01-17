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

ActiveRecord::Schema.define(version: 20160117150049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaings", force: true do |t|
    t.integer  "coalition_id"
    t.integer  "party_id"
    t.integer  "job_id"
    t.integer  "politian_id"
    t.integer  "city_id"
    t.integer  "education_level_id"
    t.integer  "civil_status_id"
    t.integer  "status_application_id"
    t.integer  "status_result_id"
    t.integer  "election_id"
    t.date     "generate_date"
    t.string   "tse_id"
    t.integer  "budget"
    t.string   "number"
    t.string   "name_campain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaings", ["city_id"], name: "index_campaings_on_city_id", using: :btree
  add_index "campaings", ["civil_status_id"], name: "index_campaings_on_civil_status_id", using: :btree
  add_index "campaings", ["coalition_id"], name: "index_campaings_on_coalition_id", using: :btree
  add_index "campaings", ["education_level_id"], name: "index_campaings_on_education_level_id", using: :btree
  add_index "campaings", ["election_id"], name: "index_campaings_on_election_id", using: :btree
  add_index "campaings", ["job_id"], name: "index_campaings_on_job_id", using: :btree
  add_index "campaings", ["party_id"], name: "index_campaings_on_party_id", using: :btree
  add_index "campaings", ["politian_id"], name: "index_campaings_on_politian_id", using: :btree
  add_index "campaings", ["status_application_id"], name: "index_campaings_on_status_application_id", using: :btree
  add_index "campaings", ["status_result_id"], name: "index_campaings_on_status_result_id", using: :btree

  create_table "cities", force: true do |t|
    t.string  "name",     limit: 60
    t.string  "tse_id"
    t.integer "state_id"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "civil_statuses", force: true do |t|
    t.string   "tse_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coalition_parties", force: true do |t|
    t.integer "coalition_id"
    t.integer "party_id"
  end

  add_index "coalition_parties", ["coalition_id"], name: "index_coalition_parties_on_coalition_id", using: :btree
  add_index "coalition_parties", ["party_id"], name: "index_coalition_parties_on_party_id", using: :btree

  create_table "coalitions", force: true do |t|
    t.string   "tse_id"
    t.string   "content"
    t.string   "acronym",    limit: 15
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "education_levels", force: true do |t|
    t.string   "tse_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elections", force: true do |t|
    t.string   "year"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "tse_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", force: true do |t|
    t.integer  "number"
    t.string   "acronym",    limit: 15
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "politians", force: true do |t|
    t.string   "cpf"
    t.string   "name"
    t.date     "birth_date"
    t.string   "gender",        limit: 2
    t.string   "nationality"
    t.integer  "birth_city_id"
    t.string   "voter_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string "name"
    t.string "full_name"
  end

  create_table "status_applications", force: true do |t|
    t.string   "tse_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_results", force: true do |t|
    t.string   "tse_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
