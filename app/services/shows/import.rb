module Shows
  class Import
    def initialize(ref:)
      self.ref = ref
    end

    def call
      Show.find_or_initialize_by(thetvdb_ref: ref).tap do |show|
        thetvdb.with_language(show.language.to_sym) do
          if result = thetvdb.series(ref)
            posters = result.posters

            show.title     = result.name
            show.slug      = result.slug.parameterize
            show.network   = result.network
            show.image_url = "/banners/#{posters.first.fileName}" if posters.any?
            show.overview  = result.overview
            show.imdb_ref  = result.imdbId
            show.rating    = result.siteRating.to_d
            show.save!

            begin
              Timeout.timeout(30.seconds) do
                DownloadImage.new(show).call
              end
            rescue Timeout::Error
              Rails.logger.error "Could not download image in allowed time"
            end

            Episodes::Import.new(show: show).call
          else
            Rails.logger.info 'Nothing found in TheTVDB Api'
          end
        end
      end
    end

    private

    attr_accessor :ref

    def thetvdb
      @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
    end
  end
end
