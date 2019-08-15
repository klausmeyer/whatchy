class Season < ApplicationRecord
  belongs_to :show
  has_many :episodes, dependent: :destroy

  scope :sorted_by_number, -> () { order(number: :desc) }
end
