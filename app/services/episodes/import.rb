module Episodes
  class Import
    def initialize(show:)
      self.show = show
    end

    def call
      if show.block_sync
        Rails.logger.info 'Synchronisation skipped as it is disabled for this show.'
        return
      end

      thetvdb.series(show.thetvdb_ref).episodes.each do |episode|
        next if episode.seasonNumber.to_i < 1
        next if episode.firstAired.blank? || Date.parse(episode.firstAired) > Date.today

        season = show.seasons.find_or_create_by(number: episode.seasonNumber)
        season.episodes.find_or_initialize_by(number: episode.number).tap do |record|
          record.title       = episode.name
          record.first_aired = episode.firstAired
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
