module Api
  module V1
    class SerializableEpisode < SerializableBase
      type "episodes"

      attribute :season do
        object.season.number
      end

      attributes :number, :title

      attribute(:'seen-at') { object.seen_at }
    end
  end
end
