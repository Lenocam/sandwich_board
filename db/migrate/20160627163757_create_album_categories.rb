class CreateAlbumCategories < ActiveRecord::Migration
	def change
		create_table :album_categories do |t|
			t.references :album, index: true, foreign_key: true
			t.references :category, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
