class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :meetings, :descriptions
    add_foreign_key :descriptions, :courses
  end
end
