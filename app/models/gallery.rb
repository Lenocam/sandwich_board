class Gallery < ActiveRecord::Base
	belongs_to :user
	has_many :images

	accepts_attachments_for :images, attachment: :file, append: true
end
