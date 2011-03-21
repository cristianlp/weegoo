class CreatePointsOfInterestUsers < ActiveRecord::Migration
  def self.up
    create_table :points_of_interest_users do |t|
      t.references :point_of_interest
      t.references :user
      t.boolean :been
      t.boolean :want_to_go

      t.timestamps
    end
  end

  def self.down
    drop_table :points_of_interest_users
  end
end
