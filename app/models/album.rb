class Album < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :album_galleries
	has_many :galleries, through: :album_galleries
	has_many :album_images
	has_many :images, through: :album_images

	accepts_attachments_for :images, attachment: :file, append: true
	accepts_nested_attributes_for :images
	validates :name, presence: true


	after_create :add_images_to_user

	def add_images_to_user
	images.each do |image|
		image.update(user: user)
		end
	end
end
#add tags to albums accessable to gallery
#or find way to add and remove existing albums from gallery
