module Api
  module V1
    module Shows
      class UpcomingController < BaseController
        def index
          respond_with ::Shows::UnseenQuery.new.for_user(current_user, future: true).sorted_by_title.page(page_number).per(page_size), each_serializer: ShowSerializer
        end
      end
    end
  end
end
