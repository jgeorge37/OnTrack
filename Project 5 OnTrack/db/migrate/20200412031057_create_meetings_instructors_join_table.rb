class CreateMeetingsInstructorsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :meetings, :instructors do |t|
      t.index :meeting_id
      t.index :instructor_id
    end
  end
end
