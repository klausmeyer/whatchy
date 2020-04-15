module Api
  module V1
    class ShowSerializer < ActiveModel::Serializer
      attributes :id, :title, :image, :overview, :rating

      def id
        object.slug
      end

      def image
        return if object.image.blank?

        "#{Rails.application.config.x.banner_cache_host}#{object.image}"
      end
    end
  end
end
