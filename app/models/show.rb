class Show < ApplicationRecord
  scope :sorted_by_title, -> { order(title: :asc) }

  has_many :subscriptions, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 150, 220 ]
  end

  def to_param
    slug
  end
end
