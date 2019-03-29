class AddPercToCalcPrice < ActiveRecord::Migration[5.2]
  def change
    add_column :calc_prices, :manager_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
    add_column :calc_prices, :profit_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
    add_column :calc_prices, :overheads_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
    add_column :calc_prices, :tax_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
  end
end
