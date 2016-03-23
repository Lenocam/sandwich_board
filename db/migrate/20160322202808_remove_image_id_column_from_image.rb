class RemoveImageIdColumnFromImage < ActiveRecord::Migration
  def change
    remove_column :images, :image_id, :integer
  end
end
