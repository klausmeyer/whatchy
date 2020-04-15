module Api
  module V1
    module Shows
      class SubscriptionsController < BaseController
        def index
          respond_with current_user.shows.sorted_by_title.page(page_number).per(page_size), each_serializer: ShowSerializer
        end
      end
    end
  end
end
