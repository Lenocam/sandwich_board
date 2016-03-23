class Image < ActiveRecord::Base
	#attr_accessible :image, :name
	belongs_to :user
	belongs_to :gallery
	mount_uploaders :images, ImageUploader


	before_create :default_name

	def default_name
		self.name ||= File.basename(image.filename, '.*').titleize if image
	end
end
