class RmTbPlacesDishes < ActiveRecord::Migration
  def self.up
    drop_table :places_dishes
    add_column :dishes, :place_id, :integer
  end

  def self.down
  end
end
