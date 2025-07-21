class Show < ApplicationRecord
  scope :sorted_by_title, -> { order(title: :asc) }

  has_many :subscriptions, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 150, 220 ]
  end

  def self.with_counts
    select(<<~SQL)
      shows.*,
      ( SELECT COUNT(seasons.id) FROM seasons WHERE seasons.show_id = shows.id ) AS seasons_count,
      ( SELECT COUNT(episodes.id) FROM episodes INNER JOIN seasons ON seasons.id = episodes.season_id AND seasons.show_id = shows.id ) AS episodes_count
    SQL
  end

  def to_param
    slug
  end
end
