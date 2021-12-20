module Api
  module V1
    module Shows
      class SubscriptionsController < BaseController
        def index
          render jsonapi: current_user.shows.sorted_by_title.page(page_number).per(page_size)
        end
      end
    end
  end
end
