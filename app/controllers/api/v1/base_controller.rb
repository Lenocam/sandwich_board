module Api
  module V1
    class BaseController < ApplicationController
      include Pundit
      protect_from_forgery with: :null_session

      before_action :destroy_session
      rescue_from ActiveRecord::RecordNotFound, with: :not_found!
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      attr_accessor :current_user
      protected

        def destroy_session
          request.session_options[:skip] = true
        end

        def unauthenticated!
          response.headers["WWW-Authenticate"] = "Token realm=Application"
          render json: { error: "No Ticket!" }, status: 401
        end

        def not_found!
          render status: 404, json: 'Not here buddy'
        end

        def user_not_authorized
          render json: {error: "Not authorized to veiw this page"}, status: 401
        end

        def authenticated_user!
          token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

          user_email = options.blank?? nil : options[:email]
          user = user_email && User.find_by(email: user_email)


          if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
            @current_user = user
          else
            return unauthenticated!
          end
        end

    end
  end
end
