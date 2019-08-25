class Shows::StatesController < ApplicationController
  def update
    service.call

    redirect_back fallback_location: show_path(show)
  end

  private

  def service
    EpisodeStates::BulkUpdate.new(parent: show, user: current_user, params: update_params)
  end

  def update_params
    params.permit(:seen)
  end

  def show
    @show ||= Show.find_by! slug: params[:show_slug]
  end
end
