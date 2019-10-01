class Episodes::StatesController < ApplicationController
  def update
    @state = current_user.episode_states.find_or_initialize_by(episode_id: params[:episode_id])
    @state.update!(seen_at: params[:seen].present? ? Time.current : nil)
  end
end
