class Album < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :album_galleries
	has_many :galleries, through: :album_galleries
	has_many :album_images
	has_many :images, through: :album_images
end
