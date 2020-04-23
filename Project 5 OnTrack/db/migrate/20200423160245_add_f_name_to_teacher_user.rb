class AddFNameToTeacherUser < ActiveRecord::Migration[6.0]
  def change
    add_column :teacher_users, :f_name, :string
  end
end
