module Api
  module V1
    module Shows
      class EpisodesController < BaseController
        def index
          respond_with show.episodes.with_and_ordered_by_season.page(page_number).per(page_size), each_serializer: EpisodeSerializer
        end

        private

        def show
          Show.find_by!(slug: params[:show_slug])
        end
      end
    end
  end
end
