class AddTaxToCustCat < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_category_parameters, :tax_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
    add_column :calc_percents, :tax_percent, :decimal, precision: 5, scale: 2, null: false, default: 0.00
  end
end
