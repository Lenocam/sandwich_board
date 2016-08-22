class ImagesController < ApplicationController
		before_action :logged_in_user
		before_action :set_image, only: [:show, :edit, :update, :destroy]
		respond_to :js
		respond_to :html
		respond_to :json

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
				params.require(:image).permit(:file, :start_at, :end_at, category_ids: [])
		end
end
