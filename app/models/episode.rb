class Episode < ApplicationRecord
  belongs_to :season
  has_one :show, through: :season
  has_many :episode_states, dependent: :destroy

  scope :aired, -> { where("first_aired IS NULL OR first_aired <= ?", Date.today) }
  scope :upcoming, -> { where("first_aired > ?", Date.today) }

  scope :sorted_by_number, -> { order(number: :asc) }

  def self.with_episode_states_for(user:)
    select([ self.arel_table[Arel.star], EpisodeState.arel_table[:seen_at] ]).joins(
      self.arel_table.join(EpisodeState.arel_table, Arel::Nodes::OuterJoin).on(
        EpisodeState.arel_table[:episode_id].eq(self.arel_table[:id]).and(
        EpisodeState.arel_table[:user_id].eq(user.id))
      ).join_sources
    )
  end

  def self.with_and_ordered_by_season
    includes(:season).order("seasons.number ASC, episodes.number ASC")
  end

  def display_number
    "S%02dE%02d" % [ season.number, number ]
  end
end
