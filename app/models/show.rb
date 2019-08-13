class Show < ApplicationRecord
  scope :sorted_by_title, -> { order(title: :asc)}

  has_many :subscriptions
  has_many :seasons
  has_many :episodes, through: :seasons

  def to_param
    slug
  end
end
