module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email

      def id
        object.email
      end
    end
  end
end
