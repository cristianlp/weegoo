class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :name
      t.references :category

      t.timestamps
    end
    add_index :sub_categories, :category_id
  end
end
