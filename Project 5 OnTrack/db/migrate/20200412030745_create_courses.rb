class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :class_num
      t.string :semester

      t.timestamps
    end
  end
end
