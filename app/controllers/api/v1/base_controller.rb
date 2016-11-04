module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :destroy_session
      rescue_from ActiveRecord::RecordNotFound, with: :not_found!

      def destroy_session
        request.session_options[:skip] = true
      end

      def not_found!
        render status: 404, json: 'Not Found'
      end

      def authenticated_user!
        token, options = ActionController::HttpAuthentification::Token.token_and_options(request)

        user_email = options.blank?? nil : options[:email]
        user = user_email && user.find_by(email: user_email)

        if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
          @current_user = user
        else
          return unauthenticated!
        end
      end

    end
  end
end
