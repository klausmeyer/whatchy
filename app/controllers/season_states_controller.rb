class SeasonStatesController < ApplicationController
  def update
    service.call

    redirect_to show_path(season.show, anchor: anchor)
  end

  private

  def service
    EpisodeStates::BulkUpdate.new(parent: season, user: current_user, params: update_params)
  end

  def update_params
    params.permit(:seen)
  end

  def season
    Season.find params[:season_id]
  end

  def anchor
    ActionView::RecordIdentifier.dom_id(season)
  end
end
