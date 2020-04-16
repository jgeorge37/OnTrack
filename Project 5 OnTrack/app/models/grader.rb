class Grader < ApplicationRecord
  has_and_belongs_to_many :descriptions
  has_and_belongs_to_many :grader_completed_course
  has_and_belongs_to_many :grader_time_availability
  has_and_belongs_to_many :grader_previous_course
end
