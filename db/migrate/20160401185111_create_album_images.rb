class CreateAlbumImages < ActiveRecord::Migration
  def change
    create_table :album_images do |t|
      t.references :album, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
