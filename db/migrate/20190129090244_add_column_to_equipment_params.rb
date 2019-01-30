class AddColumnToEquipmentParams < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment_parameters, :depreciation_type, :boolean, null: false, default: 0
  end
end
