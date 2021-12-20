module Api
  module V1
    class SerializableShow < SerializableBase
      type 'shows'

      id { @object.slug }

      attributes :title, :overview, :rating

      attribute :image do
        return if object.image.blank?

        "#{Rails.application.config.x.banner_cache_host}#{object.image}"
      end
    end
  end
end
