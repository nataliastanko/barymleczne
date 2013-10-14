class AddIpIKluczObcyTovotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :place_id, :integer
    add_column :votes, :ip, :string
  end

  def self.down
  end
end
