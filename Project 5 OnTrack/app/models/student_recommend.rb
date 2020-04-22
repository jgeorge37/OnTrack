class StudentRecommend < ApplicationRecord
  validates :student_fname, :student_lname, :student_lname_num, presence: true
end
