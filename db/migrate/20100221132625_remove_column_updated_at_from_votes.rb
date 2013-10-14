class RemoveColumnUpdatedAtFromVotes < ActiveRecord::Migration
  def self.up
remove_column :votes, :updated_at
  end

  def self.down
  end
end
