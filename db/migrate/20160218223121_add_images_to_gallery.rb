class AddImagesToGallery < ActiveRecord::Migration
	def change
		add_column :galleries, :images, :string, array: true, default: [] #add images column as array
	end
end
