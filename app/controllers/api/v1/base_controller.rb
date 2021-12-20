module Api
  module V1
    class BaseController < Api::BaseController
      def serializeables_namespace
        'Api::V1'
      end
    end
  end
end
