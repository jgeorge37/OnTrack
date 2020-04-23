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

ActiveRecord::Schema.define(version: 2020_04_23_194413) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "class_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "class_num"
    t.string "semester"
    t.string "name"
    t.string "session"
    t.string "component"
    t.boolean "attendance"
    t.integer "num_graders"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses_graders", id: false, force: :cascade do |t|
    t.integer "grader_id", null: false
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_courses_graders_on_course_id"
    t.index ["grader_id"], name: "index_courses_graders_on_grader_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "instructor_fname"
    t.string "instructor_lname"
    t.string "instructor_name_dotnum"
    t.string "grader_lname_dotnum"
    t.string "course"
    t.integer "quality"
    t.integer "punctuality"
    t.integer "com_skills"
    t.integer "course_knowledge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grader_completed_courses", force: :cascade do |t|
    t.integer "grader_id"
    t.integer "course_id"
    t.string "grade"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grader_previous_grade_courses", force: :cascade do |t|
    t.integer "grader_id"
    t.integer "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grader_time_availabilities", force: :cascade do |t|
    t.integer "grader_completed_course_id"
    t.string "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "graders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name_dot"
    t.decimal "gpa", precision: 8, scale: 2
    t.integer "account_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "instructors_meetings", id: false, force: :cascade do |t|
    t.integer "meeting_id", null: false
    t.integer "instructor_id", null: false
    t.index ["instructor_id"], name: "index_instructors_meetings_on_instructor_id"
    t.index ["meeting_id"], name: "index_instructors_meetings_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "location"
    t.string "time"
    t.integer "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "f_name"
    t.string "l_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_recommends", force: :cascade do |t|
    t.string "student_fname"
    t.string "student_lname"
    t.integer "student_lname_num"
    t.string "teacher_fname"
    t.string "teacher_lname"
    t.integer "teacher_lname_num"
    t.string "course"
    t.string "course_section"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "semester"
    t.string "course_specification"
  end

  create_table "teacher_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "f_name"
    t.string "l_name"
    t.integer "dot_num"
    t.index ["email"], name: "index_teacher_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teacher_users_on_reset_password_token", unique: true
  end

  create_table "teachings", force: :cascade do |t|
    t.integer "class_number"
    t.string "component"
    t.string "location"
    t.string "times"
    t.string "instructor"
    t.string "session"
    t.string "topic"
    t.string "semester"
    t.integer "class_name_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin"
    t.string "category"
    t.integer "profile_id"
    t.string "f_name"
    t.string "l_name"
    t.integer "dot_num"
    t.float "gpa"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meetings", "courses"
  add_foreign_key "users", "profiles"
end
