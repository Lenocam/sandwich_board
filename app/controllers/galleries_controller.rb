class GalleriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  def index
    @galleries = current_user.galleries.all
  end

  def new
    @gallery = current_user.galleries.build
  end

  def create
    @gallery = current_user.galleries.create(gallery_params)
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new, notice: 'There was a problem' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
       end
    end
  end

  def show
    @gallery_images = @gallery.categories_images
  end

  def edit
  end

  def update
    if @gallery.update(gallery_params)
      flash[:success] = 'Gallery Updated'
      redirect_to @gallery
    else
      render 'edit'
    end
  end

  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to user_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:title, images_files: [], category_ids: [])
  end
end
