class RemoveColumnsFromImage < ActiveRecord::Migration
	def change
		remove_column :images, :gallery_id
		remove_column :images, :album_id
	end
end
