class CreateMediaFileComments < ActiveRecord::Migration
  def self.up
    create_table :media_file_comments do |t|
      t.references :media_file
      t.references :user
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :media_file_comments
  end
end
