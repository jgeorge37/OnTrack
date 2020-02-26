class AddSemesterToTeachings < ActiveRecord::Migration[6.0]
  def change
    add_column :teachings, :semester, :string
  end
end
