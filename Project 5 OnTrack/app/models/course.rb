class Course < ApplicationRecord
  has_many :meetings, dependent: :delete_all
  has_and_belongs_to_many :graders
end
