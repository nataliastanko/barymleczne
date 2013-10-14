class CreateDishes < ActiveRecord::Migration
  def self.up
    create_table :dishes do |t|
      t.float :price
      t.boolean :is_available

      t.timestamps
    end
  end

  def self.down
    drop_table :dishes
  end
end
