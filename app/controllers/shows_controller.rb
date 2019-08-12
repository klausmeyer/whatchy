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
      Show.find_or_initialize_by(thetvdb_ref: ref) do |show|
        result = thetvdb.series(ref)
        show.title    = result.name
        show.image    = result.poster_url
        show.overview = result.overview
        show.save!
      end
    end

    redirect_to shows_path
  end

  private

  def thetvdb
    @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
  end
end
