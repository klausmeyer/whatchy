module Api
  module V1
    module Shows
      class UnseenController < BaseController
        def index
          render jsonapi: ::Shows::UnseenQuery.new.for_user(current_user, future: false).sorted_by_title.page(page_number).per(page_size)
        end
      end
    end
  end
end
