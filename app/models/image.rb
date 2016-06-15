class Image < ActiveRecord::Base
  belongs_to :user

  has_many   :gallery_images, dependent: :destroy
  has_many   :galleries, through: :gallery_images

  has_many   :album_images, dependent: :destroy
  has_many   :albums, through: :album_images

  attachment :file, type: :image
  validates  :file, presence: true

  before_save :set_dimensions, if: :file_id_changed?

  def set_dimensions
    fileio = file.to_io

    if fileio.is_a?(StringIO)
      mm = MiniMagick::Image.read(fileio.read)
    else
      file = fileio.to_io
      mm = MiniMagick::Image.open(file)
    end

    self.width  = mm.width
    self.height = mm.height
  end
end
