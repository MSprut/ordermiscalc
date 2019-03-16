class CreateCalcInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_inventories do |t|
      t.references :calculation
      t.references :inventory_parameter
      t.decimal :quantity, :decimal, precision: 12, scale: 6, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
