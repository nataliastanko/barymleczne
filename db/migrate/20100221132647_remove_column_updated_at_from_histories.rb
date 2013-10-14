class RemoveColumnUpdatedAtFromHistories < ActiveRecord::Migration
  def self.up
remove_column :histories, :updated_at
  end

  def self.down
  end
end
