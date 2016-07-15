class AddTimeToImages < ActiveRecord::Migration
  def change
    add_column :images, :start_time, :datetime
    add_column :images, :end_time, :datetime
  end
end
