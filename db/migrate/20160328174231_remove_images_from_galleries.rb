class RemoveImagesFromGalleries < ActiveRecord::Migration
	def change
		remove_column :galleries, :images, :string, default: [], array: true
		add_column :galleries, :image_id, :string
	end
end
