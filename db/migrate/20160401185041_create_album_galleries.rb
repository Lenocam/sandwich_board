class CreateAlbumGalleries < ActiveRecord::Migration
  def change
    create_table :album_galleries do |t|
      t.references :gallery, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
