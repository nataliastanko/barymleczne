class CreateOpenHours < ActiveRecord::Migration
  def self.up
    create_table :open_hours do |t|
      t.string :from_day
      t.string :to_day
      t.time :from_hour
      t.time :to_hour
      t.references :place
    end
  end

  def self.down
    drop_table :open_hours
  end
end
