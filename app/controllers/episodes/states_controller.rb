class Episodes::StatesController < ApplicationController
  def update
    update_state

    respond_to do |f|
      f.html { head :no_content }
      f.js   { render js: 'Turbolinks.clearCache(); Turbolinks.visit(window.location, { action: "replace" });' }
    end
  end

  private

  def update_state
    state.update!(seen_at: params[:seen].present? ? Time.current : nil)
  end

  def state
    current_user.episode_states.find_or_initialize_by(episode_id: params[:episode_id])
  end
end
