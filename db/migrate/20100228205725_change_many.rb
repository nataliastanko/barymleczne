class ChangeMany < ActiveRecord::Migration
  def self.up  
   remove_column :places, :pieces
   remove_column :places, :weight
   add_column :dishes, :weight, :integer
   add_column :dishes, :pieces, :integer
  end

  def self.down
  end
end
