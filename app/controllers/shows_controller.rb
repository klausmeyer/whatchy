class ShowsController < ApplicationController
  def index
    @shows = Show.sorted_by_title.page(page)
  end

  def show
    @show = Show.find_by! slug: params[:slug]
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
