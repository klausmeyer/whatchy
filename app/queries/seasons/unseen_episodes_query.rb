module Seasons
  class UnseenEpisodesQuery
    def initialize(season)
      self.season = season
    end

    def for_user(user)
      left_outer_join = Episode.arel_table.join(EpisodeState.arel_table, Arel::Nodes::OuterJoin).on(
        EpisodeState.arel_table[:episode_id].eq(Episode.arel_table[:id]).and(
        EpisodeState.arel_table[:user_id].eq(user.id))
      ).join_sources

      season.episodes.joins(left_outer_join).where(episode_states: {seen_at: nil})
    end

    private

    attr_accessor :season
  end
end
