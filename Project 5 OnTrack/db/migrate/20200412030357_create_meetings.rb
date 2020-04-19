class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :location
      t.string :time
      t.integer :course_id

      t.timestamps
    end
  end
end
