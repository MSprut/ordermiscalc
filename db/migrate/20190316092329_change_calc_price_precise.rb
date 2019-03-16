class ChangeCalcPricePrecise < ActiveRecord::Migration[5.2]
  def change
    change_column :calculations, :price, :decimal, precision: 12, scale: 4, null: false, default: 0.0000
  end
end
