class Gallery < ActiveRecord::Base
	belongs_to :user
	validates  :user_id, presence: true
	validates  :title, presence: true

	has_many   :gallery_images, dependent: :destroy
	has_many   :images, through: :gallery_images

	has_many   :category_galleries
	has_many   :categories, through: :category_galleries

	accepts_attachments_for       :images, attachment: :file, append: true
	accepts_nested_attributes_for :images
	validates :title, presence: true
	validates_uniqueness_of :title, scope: :user_id
	after_create :add_images_to_user

	def categories_images
		categories.flat_map(&:images).uniq
	end

	def now
		view = []
		categories_images.select do |image|
			if image[:start_at] && image[:start_at] < DateTime.now
				view << image if image[:end_at].nil? || image[:end_at] > DateTime.now
			end
		end
	end

	def add_images_to_user
		images.each do |image|
			image.update(user: user)
		end
	end
end
