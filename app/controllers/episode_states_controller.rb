class EpisodeStatesController < ApplicationController
  def update
    update_state

    head :no_content
  end

  private

  def update_state
    state.update!(seen_at: params[:seen] == '1' ? Time.current : nil)
  end

  def state
    current_user.episode_states.find_or_initialize_by(episode_id: params[:episode_id])
  end
end
