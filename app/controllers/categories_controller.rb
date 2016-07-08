class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :all_categories, only: [:index, :create, :update, :destroy]
  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.create(category_params)
    if @category.save!
      respond_to do |format|
        format.html
        format.js
      end

    end
  end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, gallery_ids: [], images_files: [])
  end

  def all_categories
    @categories = current_user.categories.all
  end
end
