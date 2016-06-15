class Gallery < ActiveRecord::Base
  belongs_to :user

  has_many   :gallery_images, dependent: :destroy
  has_many   :images, through: :gallery_images

  has_many   :album_galleries, dependent: :destroy
  has_many   :albums, through: :album_galleries
  # has_many   :images, through: :album_galleries, source: :album

  accepts_attachments_for       :images, attachment: :file, append: true
  accepts_nested_attributes_for :images

  def all_images
    images + albums.map(&:images).flatten.uniq
  end

  def add_album_to_gallery
  end

  validates :title, presence: true

  after_create :add_images_to_user

  def add_images_to_user
    images.each do |image|
      image.update(user: user)
    end
  end
end
