class CreateEquipmentParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment_parameters do |t|
      t.references :equipment
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.00
      t.integer :lifetime, null: false, default: 0.00
      t.integer :power, null: false, default: 0
      t.boolean :actual, null: false, default: 1
      t.timestamps limit: 6, null: false
    end
  end
end
