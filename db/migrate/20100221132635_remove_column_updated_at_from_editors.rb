class RemoveColumnUpdatedAtFromEditors < ActiveRecord::Migration
  def self.up
remove_column :editors, :updated_at
  end

  def self.down
  end
end
