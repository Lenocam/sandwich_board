module Api
  module V1
    class SessionsController < BaseController
      def create
        user = User.find_by(email: create_params[:email])
        if user && user.authenticate(create_params[:password])
          self.current_user = user
          render json: Api::V1::SessionSerializer.new(user, root: false).to_json, status: 201
        else
          render api_error(status: 401)
        end
      end
      private
      def create_params
        params.require(:user).permit(:email, :password)

      end
    end
  end

end
