class Gallery < ActiveRecord::Base
	belongs_to :user, dependent: :destroy

	has_many   :gallery_images
	has_many   :images, through: :gallery_images #, dependent: :destroy

	has_many   :album_galleries
	has_many   :albums, through: :album_galleries #, dependent: :destroy

	accepts_attachments_for       :images, attachment: :file, append: true
	accepts_nested_attributes_for :images
















	validates :title, presence: true

	after_create :add_images_to_user

	def add_images_to_user
	images.each do |image|
		image.update(user: user)
		end
	end
end
