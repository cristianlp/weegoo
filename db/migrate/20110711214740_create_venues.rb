class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.references :category
      t.references :sub_category
      t.float :latitude
      t.float :longitude
      t.references :user
      t.string :permalink

      t.timestamps
    end
    add_index :venues, :category_id
    add_index :venues, :sub_category_id
    add_index :venues, :user_id
  end
end
