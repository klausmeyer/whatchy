class ShowsController < ApplicationController
  def index
    page_title "Explore"

    @shows = Show.sorted_by_title
    @shows = @shows.where("title ILIKE ?", "%#{params[:search]}%") if params.key?(:search)
    @shows = @shows.page(page)
  end

  def show
    @show = Show.find_by! slug: params[:slug]

    page_title @show.title
  end

  def search
    @results = thetvdb.search(name: params[:keywords]).first(15)
  end

  def create
    redirect_to Shows::Import.new(ref: params[:ref]).call
  end

  private

  def page
    params[:page] || 1
  end

  def thetvdb
    @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
  end
end
