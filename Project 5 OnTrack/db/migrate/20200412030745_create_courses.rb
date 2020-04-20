class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :class_num
      t.string :semester
      t.string :name
      t.string :session
      t.string :component
      t.boolean :attendance
      t.integer :num_graders

      t.timestamps
    end
  end
end
