class ChageTypeColumnDescriptionInPlace < ActiveRecord::Migration
  def self.up
    change_column :places, :description, :text
  end

  def self.down
  end
end
