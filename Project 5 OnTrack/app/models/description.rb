class Description < ApplicationRecord
  has_many :meetings, dependent: :delete_all
  belongs_to :course
  has_and_belongs_to_many :graders
end
