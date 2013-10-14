class CreateChanges < ActiveRecord::Migration
  def self.up
    create_table :changes do |t|
      t.text :description
      t.string :email
      t.string :author
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :changes
  end
end
