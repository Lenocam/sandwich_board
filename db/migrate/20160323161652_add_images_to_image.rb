class AddImagesToImage < ActiveRecord::Migration
	def change
		add_column :images, :images, :string, array: true, default: [] #add images column as array
	end
end
