class CreatePointsOfInterest < ActiveRecord::Migration
  def self.up
    create_table :points_of_interest do |t|
      t.string :name
      t.text :description
      t.references :category
      t.references :sub_category
      t.float :latitude
      t.float :longitude
      t.date :date
      t.time :time
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :points_of_interest
  end
end
