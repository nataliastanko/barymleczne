class ZmienNazwePolaNewsIdodajPole < ActiveRecord::Migration
  def self.up
  rename_column :news, :for_editors_only, :for_editors
  add_column :news, :for_guests, :boolean
  end

  def self.down
  end
end
