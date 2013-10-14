class AadColumnActiveToEditors < ActiveRecord::Migration
  def self.up

   add_column :editors, :active, :boolean
  end

  def self.down
  end
end
