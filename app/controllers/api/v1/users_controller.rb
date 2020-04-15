module Api
  module V1
    class UsersController < Api::BaseController
      def show
        respond_with current_user
      end
    end
  end
end
