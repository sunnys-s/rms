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

ActiveRecord::Schema.define(version: 2019_12_23_071344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessment_attachments", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.string "attachment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assessment_id"], name: "index_assessment_attachments_on_assessment_id"
  end

  create_table "assessment_masters", force: :cascade do |t|
    t.text "statement"
    t.string "assessment_param"
    t.bigint "award_master_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_master_id"], name: "index_assessment_masters_on_award_master_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.bigint "nomination_id", null: false
    t.text "statement"
    t.text "feedback"
    t.string "value_addition"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "assessment_param"
    t.index ["nomination_id"], name: "index_assessments_on_nomination_id"
  end

  create_table "award_masters", force: :cascade do |t|
    t.string "title"
    t.string "award_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "awards", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.bigint "award_master_id", null: false
    t.string "title"
    t.string "award_type"
    t.integer "financial_year"
    t.integer "half"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "final_verdict"
    t.index ["award_master_id"], name: "index_awards_on_award_master_id"
    t.index ["cycle_id"], name: "index_awards_on_cycle_id"
  end

  create_table "commitee_members", force: :cascade do |t|
    t.bigint "commitee_id", null: false
    t.bigint "user_id", null: false
    t.boolean "representative"
    t.boolean "chairman"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commitee_id"], name: "index_commitee_members_on_commitee_id"
    t.index ["user_id"], name: "index_commitee_members_on_user_id"
  end

  create_table "commitees", force: :cascade do |t|
    t.bigint "cycle_id", null: false
    t.string "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
    t.index ["cycle_id"], name: "index_commitees_on_cycle_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies_users", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "cycles", force: :cascade do |t|
    t.string "title"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "emp_code"
    t.string "name"
    t.string "email"
    t.string "sbu"
    t.string "unit"
    t.string "department"
    t.string "location"
    t.string "reporting_manager_code"
    t.string "reporting_manager"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "functional_manager"
    t.string "administrative_manager"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "nomination_attachments", force: :cascade do |t|
    t.bigint "nomination_id", null: false
    t.string "attachment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nomination_id"], name: "index_nomination_attachments_on_nomination_id"
  end

  create_table "nominations", force: :cascade do |t|
    t.bigint "award_id", null: false
    t.string "nomination_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.string "nominator_type"
    t.bigint "nominator_id"
    t.string "state"
    t.text "justification"
    t.text "summary"
    t.text "review_feedback"
    t.text "pushback_reason"
    t.text "l1_approval_reason"
    t.text "l1_rejection_reason"
    t.integer "approvers", default: [], array: true
    t.integer "rejectors", default: [], array: true
    t.integer "company_id"
    t.boolean "innovativeness"
    t.boolean "agility"
    t.boolean "responsiveness"
    t.boolean "performance_driven"
    t.boolean "ownership"
    t.integer "subcommitee_member_ids", default: [], array: true
    t.index ["award_id"], name: "index_nominations_on_award_id"
    t.index ["nominator_type", "nominator_id"], name: "index_nominations_on_nominator_type_and_nominator_id"
  end

  create_table "nominees", force: :cascade do |t|
    t.bigint "nomination_id", null: false
    t.bigint "user_id", null: false
    t.string "emp_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", default: "active"
    t.text "rejection_reason"
    t.index ["nomination_id"], name: "index_nominees_on_nomination_id"
    t.index ["user_id"], name: "index_nominees_on_user_id"
  end

  create_table "rating_scales", force: :cascade do |t|
    t.string "title"
    t.bigint "award_master_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_master_id"], name: "index_rating_scales_on_award_master_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.string "title"
    t.integer "value"
    t.bigint "nomination_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nomination_id"], name: "index_ratings_on_nomination_id"
  end

  create_table "role_masters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_master_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_master_id"], name: "index_roles_on_role_master_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "emp_code"
    t.string "doj"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assessment_attachments", "assessments"
  add_foreign_key "assessment_masters", "award_masters"
  add_foreign_key "assessments", "nominations"
  add_foreign_key "awards", "award_masters"
  add_foreign_key "awards", "cycles"
  add_foreign_key "commitee_members", "commitees"
  add_foreign_key "commitee_members", "users"
  add_foreign_key "commitees", "cycles"
  add_foreign_key "employees", "users"
  add_foreign_key "nomination_attachments", "nominations"
  add_foreign_key "nominations", "awards"
  add_foreign_key "nominees", "nominations"
  add_foreign_key "nominees", "users"
  add_foreign_key "rating_scales", "award_masters"
  add_foreign_key "ratings", "nominations"
  add_foreign_key "roles", "role_masters"
  add_foreign_key "roles", "users"
end
