module Tvdb2
  class Client
    def self.image_url(path)
      URI::join("https://www.thetvdb.com/banners/", path).to_s
    end
  end

  class Series
    FIELDS = FIELDS + [:slug]

    attr_accessor :slug
  end
end
