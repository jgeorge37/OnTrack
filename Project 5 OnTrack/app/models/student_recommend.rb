class StudentRecommend < ApplicationRecord
  validates :student_fname, presence: true, length: { in: 1..30 }
  validates :student_lname, presence: true, length: { in: 1..30 }
  # validates :teacher_fname, presence: true, length: { in: 1..30 }
  # validates :teacher_lname, presence: true, length: { in: 1..30 }
  validates :student_lname_num, numericality: { only_integer: true }
  # validates :teacher_lname_num, numericality: { only_integer: true }
  validates :course, presence: true, numericality:{only_integer: true}, length: {is: 4}
  #validates :course_section, allow_blank: true
  validates :course_specification, presence: true
  validates :semester, presence: true
end
