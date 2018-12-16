class CreateInventoryParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_parameters do |t|
      t.references :inventory
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.00
      t.decimal :margin, precision: 5, scale: 2, null: false, default: 0.00
      t.boolean :actual, null: false, default: 1
      t.timestamps limit: 6, null: false
    end
  end
end
