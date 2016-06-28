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
        format.html { redirect_to user_categories_path, notice: 'Gallery was successfully created.' }
        format.json { render json: @resource }
      else
        format.html { render :new }
        format.html { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # code
  end

  private

  def set_category
    @album = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
