class CreatePointOfInterestComments < ActiveRecord::Migration
  def self.up
    create_table :point_of_interest_comments do |t|
      t.references :user
      t.references :point_of_interest
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :point_of_interest_comments
  end
end
