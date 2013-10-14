class ZmianaPlacesPoleTimestamps < ActiveRecord::Migration
  def self.up
   add_column :places, :created_at, :timestamp
   add_column :places, :updates_at, :timestamp
   remove_column :places, :add_date
  end

  def self.down
   remove_column :places, :created_at
   remove_column :places, :updates_at
   add_column :places, :add_date, :datetime

  end
end
