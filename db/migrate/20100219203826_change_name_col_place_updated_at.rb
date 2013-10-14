class ChangeNameColPlaceUpdatedAt < ActiveRecord::Migration
  def self.up
#zmienia typ kol
    #change_column :table_name, :column_name, :new_column_type
#rename col
    rename_column :places, :updates_at, :updated_at 
  end

  def self.down
  end
end
