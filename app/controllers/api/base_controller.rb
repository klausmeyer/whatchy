module Api
  class BaseController < ActionController::API
    before_action :doorkeeper_authorize!

    respond_to :json

    private

    def current_user
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def page_number
      params.dig(:page, :number) || 1
    end

    def page_size
      params.dig(:page, :size) || 10
    end
  end
end
