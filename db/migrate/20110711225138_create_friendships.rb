class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user_a
      t.references :user_b
      t.boolean :are_friends, :default => false

      t.timestamps
    end
    add_index :friendships, :user_a_id
    add_index :friendships, :user_b_id
  end
end
