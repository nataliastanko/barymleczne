class RenamePassword < ActiveRecord::Migration
  def self.up
    rename_column :editors, :password, :hashed_password
  end

  def self.down
    rename_column :editors,:hashed_password,  :password
  end
end
