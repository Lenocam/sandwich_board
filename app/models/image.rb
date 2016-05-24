class Image < ActiveRecord::Base
	belongs_to :user

	has_many   :gallery_images, dependent: :destroy
	has_many   :galleries, through: :gallery_images #, dependent: :destroy

	#belongs_to :album
	has_many   :album_images, dependent: :destroy
	has_many   :albums, through: :album_images #, dependent: :destroy

	attachment :file, type: :image
	validates  :file, presence: true
end
