class RetypeColToPlace < ActiveRecord::Migration
  def self.up
    change_column :places, :weight, :integer

  end

  def self.down
  end
end
