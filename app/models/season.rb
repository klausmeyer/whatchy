class Season < ApplicationRecord
  belongs_to :show
  has_many :episodes

  scope :without_specials, -> () { where.not(number: 0) }
  scope :sorted_by_number, -> () { order(number: :desc) }
end
