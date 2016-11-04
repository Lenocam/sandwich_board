module Api
  module V1
    class SessionSerializer
      attributes :id, :email, :admin, :token

      def token
        object.authentication_token
      end
    end
  end

end
