class ShowsController < ApplicationController
  def index
    @shows = Show.sorted_by_title
  end

  def new

  end

  def search
    @results = thetvdb.search(name: params[:keywords])
  end

  def create
    params[:shows].each do |ref|
      Shows::Import.new(ref: ref).call
    end

    redirect_to shows_path
  end

  private

  def thetvdb
    @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
  end
end
