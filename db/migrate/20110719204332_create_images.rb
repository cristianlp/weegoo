class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.string :caption
      t.integer :imageable_id
      t.string :imageable_type
      t.references :user

      t.timestamps
    end
    add_index :images, :user_id
  end
end
