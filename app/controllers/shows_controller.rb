class ShowsController < ApplicationController
  def index
    @shows = Show.sorted_by_title.page(page)
  end

  def show
    @show = Show.find_by! slug: params[:slug]
  end

  def new

  end

  def search
    @results = thetvdb.search(name: params[:keywords])
  end

  def create
    Array(params[:shows]).each do |ref|
      Shows::Import.new(ref: ref).call
    end

    redirect_to shows_path
  end

  private

  def page
    params[:page] || 1
  end

  def thetvdb
    @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
  end
end
