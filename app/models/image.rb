class Image < ActiveRecord::Base
	belongs_to :user
	has_many :galleries_images
	belongs_to :gallery
	has_many :galleries, through: :galleries_images
	attachment :file
end
