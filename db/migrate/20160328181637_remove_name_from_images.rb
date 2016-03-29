class RemoveNameFromImages < ActiveRecord::Migration
	def change
		remove_column :images, :name, :string
		remove_column :images, :images, default: [], array: true
		add_column    :images, :file_id, :string
	end
end
