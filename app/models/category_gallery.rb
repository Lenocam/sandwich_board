class CategoryGallery < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :category
end
