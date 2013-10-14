class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|

      t.column :filename, :string
      t.column :size, :integer
      t.column :content_type, :string
      t.column :thumbnail, :string
      t.column :parent_id, :integer
      t.column :height, :integer
      t.column :width, :integer
      
      t.column :place_id, :integer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
