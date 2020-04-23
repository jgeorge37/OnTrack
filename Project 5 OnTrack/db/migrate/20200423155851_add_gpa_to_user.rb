class AddGpaToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gpa, :float
  end
end
