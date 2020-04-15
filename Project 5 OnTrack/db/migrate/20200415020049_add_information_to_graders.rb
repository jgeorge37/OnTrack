class AddInformationToGraders < ActiveRecord::Migration[6.0]
  def change
    add_column :graders, :last_name_dot, :string
    add_column :graders, :gpa, :integer
  end
end
