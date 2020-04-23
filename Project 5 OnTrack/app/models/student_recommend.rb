class StudentRecommend < ApplicationRecord
  validates :student_fname, presence: true, length: { in: 1..30 }
end
