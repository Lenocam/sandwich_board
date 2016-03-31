class GalleriesController < ApplicationController
	before_action :set_gallery, only: [:show, :edit, :update, :destroy]

	def index
		@galleries = Gallery.all
	end

	def new
		@gallery = Gallery.new
		@gallery.images.build
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
	private
	def set_gallery
		@gallery = Gallery.find(params[:id])
	end

	def gallery_params
		params.require(:gallery).permit(:title, image_attributes: [:id, images_files: {}])
		#params.require(:gallery).permit(:title, images_files: [])
	end
end
