class Gallery < ActiveRecord::Base
	belongs_to :user
	has_many :galleries_images
	has_many :images, through: :galleries_images
	has_many :images

	accepts_attachments_for :images, attachment: :file, append: true
end
