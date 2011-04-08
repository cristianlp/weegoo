class CreateMediaFiles < ActiveRecord::Migration
  def self.up
    create_table :media_files do |t|
      t.string :title
      t.string :file
      t.references :point_of_interest

      t.timestamps
    end
  end

  def self.down
    drop_table :media_files
  end
end
