module Api
  module V1
    class SerializableUser < SerializableBase
      type "users"

      id { @object.email }

      attributes :email
    end
  end
end
