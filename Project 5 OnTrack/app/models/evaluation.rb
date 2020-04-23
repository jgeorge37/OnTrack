class Evaluation < ApplicationRecord
  validates :grader_lname_dotnum, presence: true, format:{with: /\A[a-zA-Z]+\.[1-9]\d*\z/}
  validates :course, presence: true, numericality:{only_integer: true}, length: {is: 4}
end
