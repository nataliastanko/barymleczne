class AddColumnNameToDishes < ActiveRecord::Migration
  def self.up
   add_column :dishes, :name ,:string
  end

  def self.down
  end
end
