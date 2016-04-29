class GalleriesController < ApplicationController
	before_action :set_gallery, only: [:show, :edit, :update, :destroy]

	def index
		@galleries = current_user.galleries.all
	end

	def new
		@gallery = Gallery.new
		@gallery = current_user.galleries.new
		#@gallery.images.build
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
	end

	def destroy
		@gallery.destroy
		respond_to do |format|
			format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
			format.json { head :no_content }
		end
	end
	private

	def load_parent
		current_user
	end

	def set_gallery
		@gallery = Gallery.find(params[:id])
	end

	def gallery_params
		params.require(:gallery).permit(:title, :remove_file, images_files: [])
	end
end
