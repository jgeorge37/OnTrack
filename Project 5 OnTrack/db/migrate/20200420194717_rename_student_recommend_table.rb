class RenameStudentRecommendTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :student_recommend, :student_recommends
  end
end
