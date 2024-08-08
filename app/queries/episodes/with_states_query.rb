module Episodes
  class WithStatesQuery
    def initialize(scope)
      self.scope = scope
    end

    def for_user(user)
      join = episodes.join(episode_states, Arel::Nodes::OuterJoin).on(
        episode_states[:episode_id].eq(episodes[:id]).and(
        episode_states[:user_id].eq(user.id))
      )

      scope.select([ episodes[Arel.star], episode_states[:seen_at] ]).joins(join.join_sources)
    end

    private

    attr_accessor :scope

    def episodes
      Episode.arel_table
    end

    def episode_states
      EpisodeState.arel_table
    end
  end
end
