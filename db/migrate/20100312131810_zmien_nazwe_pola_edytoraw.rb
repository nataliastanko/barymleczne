class ZmienNazwePolaEdytoraw < ActiveRecord::Migration
  def self.up
rename_column :news, :author_id, :editor_id
  end

  def self.down
  end
end
