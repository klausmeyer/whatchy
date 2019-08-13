class SeasonStatesController < ApplicationController
  def update
    update_states

    redirect_to season.show
  end

  private

  def update_states
    # TODO: Service class?
    season.episodes.each do |episode|
      episode.episode_states.find_or_initialize_by(user: current_user).tap do |state|
        state.seen_at = params[:seen].to_s == 'true' ? Time.current : nil
        state.save!
      end
    end
  end

  def season
    Season.find params[:season_id]
  end
end
