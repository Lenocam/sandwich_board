module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :authenticated_user!
      after_action :verify_authorized

      def show
        authorize current_user
        render json: { error: "Failed to find" }, status: :not_found! and return unless @user
        render json: @user, serializer: UserSerializer
      end

      def index
        @users = User.all
        render json: @users, each_serializer: UserSerializer
      end
      private
      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
