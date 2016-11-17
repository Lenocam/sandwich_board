module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :activated, :admin, :created_at, :updated_at
      attribute :authentication_token, if: :current_user

      def created_at
        object.created_at.in_time_zone.iso8601 if object.created_at
      end
      def updated_at
        object.updated_at.in_time_zone.iso8601 if object.created_at
      end
    end
  end
end
