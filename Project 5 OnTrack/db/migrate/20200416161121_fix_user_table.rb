class FixUserTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :course_section, :string
  end
end
