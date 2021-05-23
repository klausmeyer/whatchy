module Api
  module V1
    class EpisodeSerializer < ActiveModel::Serializer
      attributes :id, :season, :number, :title, :seen_at

      def season
        object.season.number
      end
    end
  end
end
