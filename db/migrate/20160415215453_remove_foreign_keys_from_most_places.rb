class RemoveForeignKeysFromMostPlaces < ActiveRecord::Migration
	def change
		remove_column :albums, :gallery_id
	end
end
