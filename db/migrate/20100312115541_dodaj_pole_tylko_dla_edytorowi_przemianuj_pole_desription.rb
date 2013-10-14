class DodajPoleTylkoDlaEdytorowiPrzemianujPoleDesription < ActiveRecord::Migration
  def self.up
   rename_column :news, :description, :contents
   add_column :news, :for_editors_only, :boolean
  end

  def self.down
  end
end
