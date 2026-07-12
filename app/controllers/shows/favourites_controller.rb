class Shows::FavouritesController < ApplicationController
  def create
    current_user.favourites.create!(show: show)

    redirect_success
  end

  def destroy
    current_user.favourites.where(show: show).delete_all

    redirect_success
  end

  private

  def show
    Show.find_by! slug: params[:show_slug]
  end

  def redirect_success
    redirect_back fallback_location: shows_path, flash: { notice: "Your favourite has been updated" }
  end
end
