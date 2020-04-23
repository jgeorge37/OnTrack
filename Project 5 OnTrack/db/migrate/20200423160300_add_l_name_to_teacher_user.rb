class AddLNameToTeacherUser < ActiveRecord::Migration[6.0]
  def change
    add_column :teacher_users, :l_name, :string
  end
end
