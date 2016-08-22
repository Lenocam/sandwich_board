class Image < ActiveRecord::Base
	belongs_to :user

	has_many   :gallery_images, dependent: :destroy
	has_many   :galleries, through: :gallery_images

	has_many   :categories, through: :category_images
	has_many   :category_images

	attachment  :file, type: :image
	validates   :file, presence: true

	before_save :set_dimensions, if: :file_id_changed?
	validate :time_in_future
	validate :end_after_start
	before_save :end_at_plus_20_years, if: :end_at_present?

	require 'date'

	private

	def end_at_plus_20_years
		self.end_at = DateTime.current + 20.years
	end

	def end_at_present?
		:end_at_plus_20_years if start_at? && !end_at?
	end

	def time_in_future
		if start_at? do
			errors[:base] << 'The Start Date must be in the Future' if start_at < DateTime.current + 15.minutes
		end
		end
	end

	def end_after_start
		if start_at? && end_at? do
				 errors[:base] << 'The Start Date must be before the End Date.' if end_at < start_at
			 end
		end
	end

	def set_dimensions
		fileio = file.to_io
		mm = if fileio.is_a?(StringIO)
					 MiniMagick::Image.read(fileio.read)
				 else
					 MiniMagick::Image.read(file)
				 end

		self.width  = mm.width
		self.height = mm.height
	end
end
