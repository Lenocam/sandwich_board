class AddColumnsToAlbums < ActiveRecord::Migration
	def change
		add_column :albums, :user_id, :integer
		add_column :albums, :gallery_id, :integer
		add_column :albums, :name, :string
	end
end
