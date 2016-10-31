module Api
  module V1
    class CategoriesController < BaseController
      before_action :set_category, only: [:show, :edit, :update, :destroy]
      before_action :all_categories, only: [:index]

      def index
        

      end

      private
      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
