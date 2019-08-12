class HomeController < ApplicationController
  def index
    @shows = current_user.shows.sorted_by_title
  end
end
