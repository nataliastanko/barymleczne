class RenameStatusToDone < ActiveRecord::Migration
  def self.up
   rename_column :changes, :status, :done
  end

  def self.down
  end
end
