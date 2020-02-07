class SubscriptionsController < ApplicationController
  def index
    @shows = current_user.shows.sorted_by_title.page(page)
  end

  def upcoming
    @shows = Shows::UnseenQuery.new.for_user(current_user, future: true).sorted_by_title.page(page)
  end

  private

  def page
    params[:page] || 1
  end
end
