class RemoveColumnUpdatedAtInComments < ActiveRecord::Migration
  def self.up  
    remove_column :comments, :updated_at
  end

  def self.down
  end
end
