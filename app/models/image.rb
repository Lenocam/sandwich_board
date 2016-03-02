class Image < ActiveRecord::Base
	belongs_to :user
	belongs_to :gallery
	validates :user_id, presence: true
end
