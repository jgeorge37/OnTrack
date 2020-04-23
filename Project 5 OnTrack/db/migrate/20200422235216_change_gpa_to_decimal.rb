class ChangeGpaToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :graders, :gpa, :decimal, :precision => 8, :scale => 2
  end
end
