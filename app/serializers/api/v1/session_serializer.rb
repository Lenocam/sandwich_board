module Api
  module V1
    class SessionSerializer
      attributes :id, :email, :admin, :token
    end
  end

end

attributes :id, :email, :token, :admin

def token
  object.authentication_token
end
