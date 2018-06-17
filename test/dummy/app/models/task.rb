class Task < ApplicationRecord
  validates :title, presence: true
end
