class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :venue
      t.string :name
      t.text :description
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time

      t.timestamps
    end
    add_index :events, :venue_id
  end
end
