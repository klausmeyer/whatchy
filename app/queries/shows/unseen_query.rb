module Shows
  class UnseenQuery
    def for_user(user, future: false)
      operator = future ? :gt : :lteq

      user.shows.with_counts.includes([ :image_attachment ]).where(Show.arel_table[:id].in(Season.arel_table
        .join(Episode.arel_table).on(
          Episode.arel_table[:season_id].eq(Season.arel_table[:id]).and(
          Episode.arel_table[:first_aired].public_send(operator, Date.today))
        )
        .join(EpisodeState.arel_table, Arel::Nodes::OuterJoin).on(
          EpisodeState.arel_table[:episode_id].eq(Episode.arel_table[:id]).and(
          EpisodeState.arel_table[:user_id].eq(user.id))
        )
        .where(
          Season.arel_table[:show_id].eq(Show.arel_table[:id]).and(
          EpisodeState.arel_table[:seen_at].eq(nil))
        )
        .project(Season.arel_table[:show_id])
      )).order(id: :asc)
    end
  end
end
