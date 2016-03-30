class CreateJoinTableGalleryImage < ActiveRecord::Migration
	def change
		create_join_table :galleries, :images do |t|
			t.index [:gallery_id, :image_id]
			t.index [:image_id, :gallery_id]
		end
	end
end
