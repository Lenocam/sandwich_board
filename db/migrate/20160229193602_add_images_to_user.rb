class AddImagesToUser < ActiveRecord::Migration
	def change
		add_column :users, :images, :string, array: true, default: [] # add images column as array
	end
end
