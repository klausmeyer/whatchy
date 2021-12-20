module Api
  class BaseController < ActionController::API
    before_action :doorkeeper_authorize!

    def jsonapi_class
      Hash.new do |hash, key|
        names = key.to_s.split('::')
        klass = names.pop
        hash[key] = [serializeables_namespace, *names, "Serializable#{klass}"].join('::').safe_constantize
      end
    end

    def jsonapi_object
      nil
    end

    def jsonapi_pagination(collection)
      return {} unless collection.is_a? ActiveRecord::AssociationRelation

      {
        first: pagination_link(collection.limit_value, 1),
        last:  pagination_link(collection.limit_value, collection.current_page),
        next:  pagination_link(collection.limit_value, collection.next_page),
        prev:  pagination_link(collection.limit_value, collection.prev_page),
        self:  pagination_link(collection.limit_value, collection.current_page),
      }
    end

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

    def pagination_link(size, number)
      return if number.nil?

      url_for(page: {size: size, number: number})
    end
  end
end
