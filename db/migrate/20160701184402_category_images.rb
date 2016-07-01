class CategoryImages < ActiveRecord::Migration
  def change
    create_table :category_images do |t|
      t.references :category, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
