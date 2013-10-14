class RemoveColumnUpdatedAtFromTags < ActiveRecord::Migration
  def self.up
remove_column :tags, :updated_at
  end

  def self.down
  end
end
