class Image < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :galleries_images
	belongs_to :gallery
	has_many :galleries, through: :galleries_images
	has_many :album_images
	has_many :albums, through: :album_images
	attachment :file
	validates :file, presence: true
end
