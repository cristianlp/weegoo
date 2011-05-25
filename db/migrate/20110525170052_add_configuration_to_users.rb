class AddConfigurationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :share_email, :boolean
    add_column :users, :share_location, :boolean
    add_column :users, :share_activity, :boolean
    add_column :users, :post_activity, :boolean
    add_column :users, :tweet_activity, :boolean
  end

  def self.down
    remove_column :users, :share_email
    remove_column :users, :share_location
    remove_column :users, :share_activity
    remove_column :users, :post_activity
    remove_column :users, :tweet_activity
  end
end
