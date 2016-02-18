class Gallery < ActiveRecord::Base
	mount_uploaders :images, ImageUploader
	belongs_to :user
	has_many :images
end
