class CreateCalcPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_prices do |t|
      t.references :calculation
      t.references :customer_category
      t.decimal :price, precision: 12, scale: 4, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
