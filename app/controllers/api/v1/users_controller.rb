module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :authenticated_user!
      before_action :correct_api_user
      #after_action :verify_authorized

      def show
        authorize @current_user
        render json: { error: "Failed to find" }, status: :not_found! and return unless @user
        render json: @user, serializer: UserSerializer
      end

      def index
        authorize @current_user
        @users = User.all
        render json: @users
      end

      private
      def set_user
        @user = User.find(params[:id])
      end

      def correct_api_user
        @user = User.find(params[:id])
        render json: { error: "Fuck off you mangy dog" } unless current_user.admin? || current_user?(@user)

      end


    end
  end
end
