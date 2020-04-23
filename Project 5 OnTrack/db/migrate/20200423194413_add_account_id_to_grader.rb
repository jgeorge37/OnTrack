class AddAccountIdToGrader < ActiveRecord::Migration[6.0]
  def change
    add_column :graders, :account_id, :integer
  end
end
