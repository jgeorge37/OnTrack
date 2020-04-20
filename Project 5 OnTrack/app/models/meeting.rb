class Meeting < ApplicationRecord
  has_and_belongs_to_many :instructors
  belongs_to :course
end
