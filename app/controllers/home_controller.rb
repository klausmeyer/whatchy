class HomeController < ApplicationController
  before_action do
    page_title "Home"
  end

  def index
    @shows = Shows::UnseenQuery.new.for_user(current_user, future: false).sorted_by_title.page(page)
  end

  private

  def page
    params[:page] || 1
  end
end
