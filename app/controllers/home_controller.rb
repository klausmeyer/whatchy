class HomeController < ApplicationController
  def index
    @shows = Shows::UnseenQuery.new.for_user(current_user, future: false).page(page)
  end

  private

  def page
    params[:page] || 1
  end
end
