class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :type
      t.references :user_a
      t.references :user_b
      t.references :point_of_interest

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
