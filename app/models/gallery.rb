class Gallery < ActiveRecord::Base
	mount_uploaders :images, ImageUploader
	belongs_to :user
	validates :user_id, presence: true
	has_many :images
end
