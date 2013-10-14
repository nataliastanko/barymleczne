class AddColumnDeletedInPlace < ActiveRecord::Migration
  def self.up
   add_column :places, :deleted, :boolean, :default => 0
  end

  def self.down
  end
end
