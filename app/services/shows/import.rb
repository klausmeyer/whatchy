module Shows
  class Import
    def initialize(ref: ref)
      self.ref = ref
    end

    def call
      Show.find_or_initialize_by(thetvdb_ref: ref) do |show|
        result = thetvdb.series(ref)
        show.title    = result.name
        show.image    = result.poster_url
        show.overview = result.overview
        show.save!
      end
    end

    private

    attr_accessor :ref

    def thetvdb
      @thetvdb ||= TVDB.new(apikey: Rails.application.config.x.thetvdb_apikey)
    end
  end
end
