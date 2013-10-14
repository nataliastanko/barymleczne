class RemoveColumnUpatedAtAndCreatedAtInCategories < ActiveRecord::Migration
  def self.up
  remove_column :categories, :updated_at	
  remove_column :categories, :created_at
  end

  def self.down
  end
end
