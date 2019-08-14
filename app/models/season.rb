class Season < ApplicationRecord
  belongs_to :show
  has_many :episodes

  scope :without_specials, -> () { where.not(number: 0) }
  scope :sorted_by_number, -> () { order(number: :desc) }

  # TODO: Move this to a helper / query-object / whatever
  def unseen_episodes_for?(user:)
    left_outer_join = Episode.arel_table.join(EpisodeState.arel_table, Arel::Nodes::OuterJoin).on(
      EpisodeState.arel_table[:episode_id].eq(Episode.arel_table[:id]).and(
      EpisodeState.arel_table[:user_id].eq(user.id))
    ).join_sources

    episodes.joins(left_outer_join).where(episode_states: {seen_at: nil}).any?
  end
end
