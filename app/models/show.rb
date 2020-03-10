class Show < ApplicationRecord
  scope :sorted_by_title, -> { order(title: :asc)}

  has_many :subscriptions, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  def to_param
    slug
  end
end
