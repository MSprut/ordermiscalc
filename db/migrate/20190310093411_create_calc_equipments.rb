class CreateCalcEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_equipments do |t|
      t.references :calculation
      t.references :equipment_parameter
      t.decimal :usage_time, :decimal, precision: 6, scale: 2, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
