class CreateTeachings < ActiveRecord::Migration[6.0]
  def change
    create_table :teachings do |t|
      t.integer :class_number
      t.string :component
      t.string :location
      t.string :times
      t.string :instructor
      t.string :session
      t.string :topic
      t.string :semester
      t.integer :class_name_id

      t.timestamps
    end
  end
end
