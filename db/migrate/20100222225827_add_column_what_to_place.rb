class AddColumnWhatToPlace < ActiveRecord::Migration
  def self.up
    add_column :histories, :what, :string
  end

  def self.down
  end
end
