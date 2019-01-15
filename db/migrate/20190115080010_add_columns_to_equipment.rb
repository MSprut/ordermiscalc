class AddColumnsToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment_parameters, :residual_price, :decimal, precision: 10, scale: 2, null: false, default: 0.00
    add_column :equipment_parameters, :standbay_power, :integer, null: false, default: 0
  end
end
