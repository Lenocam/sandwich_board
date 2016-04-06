class RemoveImageIdfromGalleries < ActiveRecord::Migration
	def change
		remove_column :galleries, :image_id
	end
end
