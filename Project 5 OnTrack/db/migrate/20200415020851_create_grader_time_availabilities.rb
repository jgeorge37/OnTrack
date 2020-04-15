class CreateGraderTimeAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :grader_time_availabilities do |t|
      t.integer :grader_completed_course_id
      t.string :time

      t.timestamps
    end
  end
end
