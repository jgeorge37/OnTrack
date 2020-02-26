class AddClassNameIdToTeachings < ActiveRecord::Migration[6.0]
  def change
    add_column :teachings, :class_name_id, :integer
  end
end
