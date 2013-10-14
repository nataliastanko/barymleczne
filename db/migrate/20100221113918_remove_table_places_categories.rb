class RemoveTablePlacesCategories < ActiveRecord::Migration
  def self.up
   drop_table :places_categories
  end

  def self.down
  end
end
