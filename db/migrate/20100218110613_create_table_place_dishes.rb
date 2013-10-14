class CreateTablePlaceDishes < ActiveRecord::Migration
  def self.up
    create_table :places_dishes, :id => false do |t|
    t.integer :place_id
    t.integer :dish_id
    end
  end

#jak ktos cofa migracje to usuwa sie tu tabela
  def self.down
    drop_table :places_dishes
  end
end
