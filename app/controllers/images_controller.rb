class ImagesController < ApplicationController
	def create
		@image = current_user.images.build(image_params)
	end

	private

	def image_params
		params.require(:image).permit(:image_file)
	end
end
