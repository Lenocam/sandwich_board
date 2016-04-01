class Gallery < ActiveRecord::Base
	belongs_to :user
	has_many :galleries_images
	has_many :images, through: :galleries_images
	has_many :images

	accepts_attachments_for :images, attachment: :file, append: true
	#accepts_nested_attributes_for :images
	validates_presence_of :title
end
