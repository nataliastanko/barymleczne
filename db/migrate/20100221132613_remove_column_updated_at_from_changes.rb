class RemoveColumnUpdatedAtFromChanges < ActiveRecord::Migration
  def self.up
remove_column :changes, :updated_at
  end

  def self.down
  end
end
