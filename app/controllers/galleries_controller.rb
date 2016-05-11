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
		@gallery = current_user.galleries.build(gallery_params)
		respond_to do |format|
				if @gallery.save
					format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
					format.json { render :show, status: :created, location: @gallery }
				else
					format.html { render :new }
					format.json { render json: @gallery.errors, status: :unprocessable_entity }
				end
			end
	end

	def show
	end

	def update
		if @gallery.update_attributes(gallery_params)
			flash[:success] = "Gallery Updated"
			redirect_to user_gallery_url
		else
			render 'edit'
		end
	end

	def destroy
		@gallery.destroy
		respond_to do |format|
			format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def set_gallery
		@gallery = Gallery.find(params[:id])
	end

	def gallery_params
		params.require(:gallery).permit(:title, images_files: [])

	end
end
