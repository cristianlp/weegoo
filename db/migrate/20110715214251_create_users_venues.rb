class CreateUsersVenues < ActiveRecord::Migration
  def change
    create_table :users_venues do |t|
      t.references :user
      t.references :venue
      t.boolean :visited
      t.boolean :to_go

      t.timestamps
    end
    add_index :users_venues, :user_id
    add_index :users_venues, :venue_id
  end
end
