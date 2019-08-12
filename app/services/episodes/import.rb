module Episodes
  class Import
    def initialize(show:)
      self.show = show
    end

    def call
      thetvdb.series(show.thetvdb_ref).episodes.each do |episode|
        season = show.seasons.find_or_create_by(number: episode.seasonNumber)
        season.episodes.find_or_initialize_by(number: episode.number).tap do |record|
          record.title = episode.name
          record.save!
        end
      end
    end

    private

    attr_accessor :show

    def thetvdb
      @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
    end
  end
end