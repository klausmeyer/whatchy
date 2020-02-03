class HomeController < ApplicationController
  def index
    @unseen_shows   = Shows::UnseenQuery.new.for_user(current_user, future: false).page(unseen_page)
    @upcoming_shows = Shows::UnseenQuery.new.for_user(current_user, future: true).page(upcoming_page)
  end

  private

  def unseen_page
    params[:unseen_page] || 1
  end

  def upcoming_page
    params[:upcoming_page] || 1
  end
end
