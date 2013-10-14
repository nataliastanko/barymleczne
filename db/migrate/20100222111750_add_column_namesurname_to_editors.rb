class AddColumnNamesurnameToEditors < ActiveRecord::Migration
  def self.up
   add_column :editors, :name_surname, :string
  end

  def self.down
   remove_column :editors, :name_surname

  end
end
