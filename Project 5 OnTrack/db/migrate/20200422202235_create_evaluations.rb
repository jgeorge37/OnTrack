class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.string :instructor_fname
      t.string :instructor_lname
      t.string :instructor_name_dotnum
      t.string :grader_lname_dotnum
      t.string :course
      t.integer :quality
      t.integer :punctuality
      t.integer :com_skills
      t.integer :course_knowledge

      t.timestamps
    end
  end
end
