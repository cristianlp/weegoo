class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships, :id => false do |t|
      t.references :user_a
      t.references :user_b
      t.boolean :are_friends, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
