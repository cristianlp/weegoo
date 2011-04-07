class AddUserIdToMediaFiles < ActiveRecord::Migration
  def self.up
    add_column :media_files, :user_id, :integer
  end

  def self.down
    remove_column :media_files, :user_id
  end
end
