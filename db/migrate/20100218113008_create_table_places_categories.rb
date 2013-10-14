class CreateTablePlacesCategories < ActiveRecord::Migration
  def self.up
   create_table :places_categories, id=>false do |t|
    t.integer :category_id
    t.integer :place_id
   end
  end

  def self.down
  end
end
