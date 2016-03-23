class Gallery < ActiveRecord::Base
	mount_uploaders :images, ImageUploader
	belongs_to :user
	has_many :images
	accepts_nested_attributes_for :images, allow_destroy: true #test
end
