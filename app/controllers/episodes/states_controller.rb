class Episodes::StatesController < ApplicationController
  def update
    @state = current_user.episode_states.find_or_initialize_by(episode_id: params[:episode_id])
    @state.update!(seen_at: params[:seen].present? ? Time.current : nil)

    redirect_to show_path(@state.episode.show, anchor: anchor), status: :see_other
  end

  private

  def anchor
    ActionView::RecordIdentifier.dom_id(@state.episode.season)
  end
end
