class AddLatitudeItp < ActiveRecord::Migration
  def self.up
    add_column :places, :longitude, :float
    add_column :places, :latitude, :float
  end

  def self.down
  end
end
