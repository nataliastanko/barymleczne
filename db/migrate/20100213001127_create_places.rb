class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :description
      t.string :street
      t.time :open_from
      t.time :open_to
      t.string :name
      t.boolean :active
      t.string :photo
      t.datetime :add_date
# alternatywa - t.column itd
#      t.column :created_at, :timestamp
#      t.column :updated_at, :timestamp
# ^^ inaczej t.timestamps ^^ te 2 pola
    end
  end

  def self.down
    drop_table :places
  end
end
