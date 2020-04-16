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

ActiveRecord::Schema.define(version: 2020_04_16_034848) do

  create_table "class_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "class_num"
    t.string "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "name"
    t.string "session"
    t.string "component"
    t.boolean "attendance"
    t.integer "num_graders"
    t.integer "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "descriptions_graders", id: false, force: :cascade do |t|
    t.integer "grader_id", null: false
    t.integer "description_id", null: false
    t.index ["description_id"], name: "index_descriptions_graders_on_description_id"
    t.index ["grader_id"], name: "index_descriptions_graders_on_grader_id"
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
    t.integer "gpa"
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
    t.integer "description_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "student_fname"
    t.string "student_lname"
    t.integer "student_lname_num"
    t.string "teacher_fname"
    t.string "teacher_lname"
    t.integer "teacher_lname_num"
    t.string "course"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
