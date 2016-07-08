class Category < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  has_many     :images, through: :category_images
  has_many     :category_images, dependent: :destroy

  has_many   :category_galleries, dependent: :destroy
  has_many   :galleries, through: :category_galleries

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  validates :description, length: { maximum: 50 }

  # Test to see if by putting name uniqueness if it keeps two different users from having the same name
end
