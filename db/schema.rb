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

ActiveRecord::Schema.define(version: 20140321175040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["patient_id"], name: "index_clients_on_patient_id", using: :btree
  add_index "clients", ["user_id", "patient_id"], name: "index_clients_on_user_id_and_patient_id", unique: true, using: :btree
  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "designations", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default",  default: false
  end

  add_index "designations", ["hospital_id"], name: "index_designations_on_hospital_id", using: :btree
  add_index "designations", ["user_id", "hospital_id"], name: "index_designations_on_user_id_and_hospital_id", unique: true, using: :btree
  add_index "designations", ["user_id"], name: "index_designations_on_user_id", using: :btree

  create_table "hospitals", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "aasm_state"
  end

  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "patients", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "surgeries", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "hospital_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "side"
    t.string   "region"
    t.string   "surgeon"
    t.string   "uhid"
  end

  add_index "surgeries", ["hospital_id"], name: "index_surgeries_on_hospital_id", using: :btree
  add_index "surgeries", ["name", "date", "hospital_id", "patient_id", "category", "side", "region", "surgeon"], name: "unique_surgery_attributes_index", unique: true, using: :btree
  add_index "surgeries", ["patient_id"], name: "index_surgeries_on_patient_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "teams", ["hospital_id"], name: "index_teams_on_hospital_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "category",               default: "guest"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
