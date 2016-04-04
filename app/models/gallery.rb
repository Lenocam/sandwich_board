class Gallery < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	has_many :gallery_images
	has_many :images, through: :gallery_images
	has_many :images
	has_many :album_galleries
	has_many :albums, through: :album_galleries

	accepts_attachments_for :images, attachment: :file, append: true
	accepts_nested_attributes_for :images
	validates :title, presence: true
end
