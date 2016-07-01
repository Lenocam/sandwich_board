class CreateCategoryGalleries < ActiveRecord::Migration
  def change
    create_table :category_galleries do |t|
      t.references :category, index: true, foreign_key: true
      t.references :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
