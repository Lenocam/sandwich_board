class ImagesController < ApplicationController
  before_action :logged_in_user
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  respond_to :js
  respond_to :html
  respond_to :json
  helper :images
  require "date"
  require "pry"

  # GET /images
  # GET /images.json
  def index
    @images = current_user.images.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = current_user.images.build
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = current_user.images.build(image_params)
    binding.pry
    @image.start_at = DateTime.strptime(params[:image][:start_at], "%m-%d-%Y %I:%M %p")
    respond_to do |format|
      if @image.save!
        format.html { redirect_to @image }
        format.json { render json: @resource }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to user_images_url(current_user), notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    allowed = params.require(:image).permit(:file, :start_at, :end_at, category_ids: [])

    # Call to Create New Categories on update/new action of images
    allowed[:category_ids] = clean_up_categories(allowed[:category_ids])
    allowed
  end

  def clean_up_categories(categories)
    valid_ids = []
    categories.each do |cat|
      next if cat.blank?
      if Category.where(id: cat).any?
        valid_ids << cat
      else
        new_cat = current_user.categories.create(name: cat)
        valid_ids << new_cat.id
      end
    end
    valid_ids
  end
end
