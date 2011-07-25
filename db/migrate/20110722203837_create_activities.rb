class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type
      t.references :user_a
      t.references :user_b
      t.references :venue
      t.references :event
      t.references :image

      t.timestamps
    end
    add_index :activities, :user_a_id
    add_index :activities, :user_b_id
    add_index :activities, :venue_id
    add_index :activities, :event_id
    add_index :activities, :image_id
  end
end
