class Gallery < ActiveRecord::Base
  belongs_to :user
  validates  :user_id, presence: true

  has_many   :gallery_images, dependent: :destroy
  has_many   :images, through: :gallery_images

  # has_many   :album_galleries, dependent: :destroy
  # has_many   :albums, through: :album_galleries

  has_many   :category_galleries
  has_many   :categories, through: :category_galleries

  accepts_attachments_for       :images, attachment: :file, append: true
  accepts_nested_attributes_for :images

  def categories_images
    categories.flat_map(&:images).uniq
  end

  validates :title, presence: true
  after_create :add_images_to_user

  def add_images_to_user
    images.each do |image|
      image.update(user: user)
    end
  end
end
