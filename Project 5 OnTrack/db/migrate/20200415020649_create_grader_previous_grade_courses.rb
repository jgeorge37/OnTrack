class CreateGraderPreviousGradeCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :grader_previous_grade_courses do |t|
      t.integer :grader_id
      t.integer :course_id

      t.timestamps
    end
  end
end
