class CreateTablePlacesTags < ActiveRecord::Migration
  def self.up
   create_table :places_tags, :id => false do |t|
    t.integer :place_id
    t.integer :tag_id
   end
  end

  def self.down
  end
end
