class AddDescripToDish < ActiveRecord::Migration
  def self.up
   add_column :dishes, :description, :string
  end

  def self.down
  end
end
