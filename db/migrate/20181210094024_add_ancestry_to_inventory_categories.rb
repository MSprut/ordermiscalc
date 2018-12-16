class AddAncestryToInventoryCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventory_categories, :ancestry, :string
    add_index :inventory_categories, :ancestry
  end
end
