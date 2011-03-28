class AddPermalinkToPointsOfInterest < ActiveRecord::Migration
  def self.up
    add_column :points_of_interest, :permalink, :string
  end

  def self.down
    remove_column :points_of_interest, :permalink
  end
end
