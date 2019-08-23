class HomeController < ApplicationController
  def index
    @shows = Shows::UnseenQuery.new.for_user(current_user).page(page)
  end

  private

  def page
    params[:page] || 1
  end
end
