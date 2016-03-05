class AddUserRefToImages < ActiveRecord::Migration
	def change
		add_reference :images, :user, index: true, foreign_key: true
		add_reference :images, :gallery, index: true, foreign_key: true
		add_column :images, :name, :string
		add_column :images, :image_id, :integer
	end
end
