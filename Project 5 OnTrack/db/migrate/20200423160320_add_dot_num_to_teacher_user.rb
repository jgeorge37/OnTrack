class AddDotNumToTeacherUser < ActiveRecord::Migration[6.0]
  def change
    add_column :teacher_users, :dot_num, :integer
  end
end
