module Api
  module V1
    class SerializableBase < JSONAPI::Serializable::Resource
      private

      attr_reader :object
    end
  end
end
