class CreateDescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :descriptions do |t|
      t.string :name
      t.string :session
      t.string :component
      t.boolean :attendance
      t.integer :num_graders
      t.integer :course_id

      t.timestamps
    end
  end
end
