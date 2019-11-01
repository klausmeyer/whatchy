class ActivitiesController < ApplicationController
  def index
    @history_entries = history_entries.sort.reverse
  end

  private

  def history_entries
    (episode_states + subscriptions).group_by do |e|
      case e
      when Subscription
        e.created_at.to_date
      when EpisodeState
        e.updated_at.to_date
      else
        raise ArgumentError
      end
    end
  end

  def subscriptions
    current_user.subscriptions.includes(:show).newest_first
  end

  def episode_states
    current_user.episode_states.includes(episode: :show).newest_first
  end
end
