class RemoveColumnsFromPlaces < ActiveRecord::Migration
  def self.up
  remove_column :places, :open_to
  remove_column :places, :open_from
  end

  def self.down
  end
end
