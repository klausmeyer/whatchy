require "open-uri"

module Shows
  class DownloadImage
    def initialize(show)
      self.show = show
    end

    def call
      return unless show.image_url.present?

      show.image.attach(
        io: URI.open(full_image_uri),
        filename: filename,
      )
    end

    private

    attr_accessor :show

    def full_image_uri
      "#{Rails.application.config.x.banner_cache_host}#{show.image_url}"
    end

    def filename
      show.image_url.split("/").last.split("?").first
    end
  end
end
