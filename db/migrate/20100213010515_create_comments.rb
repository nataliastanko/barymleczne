class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :contents
      t.timestamp :date_time
      t.string :autor
      t.string :email
      t.references :place

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
