class Category < ActiveRecord::Base
  belongs_to :user

  has_many   :albums, through: :album_categories
  has_many   :album_categories

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  # Test to see if by putting name uniqueness if it keeps two different users from having the same name
end
