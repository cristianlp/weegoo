class AddMediaFileIdToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :media_file_id, :integer
  end

  def self.down
    remove_column :activities, :media_file_id
  end
end
