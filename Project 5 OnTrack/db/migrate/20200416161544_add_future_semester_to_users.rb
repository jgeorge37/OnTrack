class AddFutureSemesterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :future_semester, :boolean
    add_column :users, :next_semester, :boolean
  end
end
