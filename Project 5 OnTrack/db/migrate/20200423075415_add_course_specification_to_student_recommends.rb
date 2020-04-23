class AddCourseSpecificationToStudentRecommends < ActiveRecord::Migration[6.0]
  def change
    add_column :student_recommends,:course_specification, :string
  end
end
