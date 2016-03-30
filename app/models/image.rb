class Image < ActiveRecord::Base
	belongs_to :user, inverse_of: :image
	belongs_to :gallery
	attachment :file
end
