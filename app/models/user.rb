class User < ActiveRecord::Base
	has_many :galleries
	has_many :images
end
