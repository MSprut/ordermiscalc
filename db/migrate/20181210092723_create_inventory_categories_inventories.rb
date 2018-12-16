class CreateInventoryCategoriesInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_categories_inventories do |t|
      t.references :inventory_category, foreign_key: true
      t.references :inventory, foreign_key: true
      t.timestamps limit: 6, null: false
    end
  end
end
