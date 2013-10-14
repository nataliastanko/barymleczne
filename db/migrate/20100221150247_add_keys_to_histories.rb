class AddKeysToHistories < ActiveRecord::Migration
  def self.up
   add_column :histories, :place_id, :integer
   add_column :histories, :editor_id, :integer
  end

  def self.down
  end
end
