class AddGoreignKeyToChanges < ActiveRecord::Migration
  def self.up
    add_column :changes, :place_id, :integer
  end

  def self.down
  end
end
