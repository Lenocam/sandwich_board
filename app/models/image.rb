class Image < ActiveRecord::Base
	belongs_to :user, dependent: :destroy

	belongs_to :gallery
	has_many   :galleries_images
	has_many   :galleries, through: :galleries_images

	belongs_to :album
	has_many   :album_images
	has_many   :albums, through: :album_images

	attachment :file
	validates  :file, presence: true

	belongs_to :album_images, dependent: :destroy
end
