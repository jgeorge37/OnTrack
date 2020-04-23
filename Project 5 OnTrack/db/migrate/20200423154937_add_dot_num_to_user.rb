class AddDotNumToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :dot_num, :integer
  end
end
