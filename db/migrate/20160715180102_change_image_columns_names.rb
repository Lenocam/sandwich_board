class ChangeImageColumnsNames < ActiveRecord::Migration
	def change
		rename_column :images, :start_time, :start_at
		rename_column :images, :end_time, :end_at
	end
end
