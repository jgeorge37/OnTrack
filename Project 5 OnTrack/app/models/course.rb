class Course < ApplicationRecord
  has_one :description, dependent: :delete
end
