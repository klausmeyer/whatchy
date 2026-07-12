class FavouritesController < ApplicationController
  def index
    page_title "Favourites"

    @shows = current_user.favourite_shows.with_counts.sorted_by_title
    @shows = @shows.page(page)
  end
end
