class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = current_user.categories.all
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to user_categories_path, notice: 'Category was successfully created.' }
        format.json { render json: @resource }
      else
        format.html { render :new, notice: "Something Happened I don't know what" }
        format.html { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description, gallery_ids: [], images_files: [])
  end
end
