class AddKeyToPlace < ActiveRecord::Migration
  def self.up
   add_column :places, :category_id, :integer
  end

  def self.down
  end
end
