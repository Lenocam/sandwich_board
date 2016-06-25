class AlbumGalleriesController < ApplicationController
	before_action :set_gallery, only: [:create]
	before_action :set_album_galleries, only: [:show, :edit, :update, :destroy]

	def create
		album = Album.find(params[:id])
		@album_galleries = @gallery.album_galleries.build(album: album)
		respond_to do |format|
			if @album_galleries.save
				format.html do
					redirect_to @gallery,
											notice: 'Album was added to gallery'
			else
				format.html { render action: 'new'}

				end

			end
		end
	end
end
