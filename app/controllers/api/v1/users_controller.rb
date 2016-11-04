module Api
  module V1
    class UsersController < BaseController
      #before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
      before_action :set_user, only: [:show, :update, :destroy]
      def show
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
