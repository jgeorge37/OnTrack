class ChangeBooleanToStringRecommendTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :student_recommends, :next_semester
    remove_column :student_recommends, :future_semester
    add_column :student_recommends, :semester, :string
  end
end
