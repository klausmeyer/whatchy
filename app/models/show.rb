class Show < ApplicationRecord
  scope :sorted_by_title, -> { order(title: :asc)}
end
