module Api
  module V1
    class UsersController < BaseController
      def show
        render jsonapi: current_user
      end
    end
  end
end
