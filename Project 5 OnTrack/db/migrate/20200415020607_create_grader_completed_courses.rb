class CreateGraderCompletedCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :grader_completed_courses do |t|
      t.integer :grader_id
      t.integer :course_id
      t.string :grade

      t.timestamps
    end
  end
end
