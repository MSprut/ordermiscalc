class AddNotesToCalcParts < ActiveRecord::Migration[5.2]
  def change
    add_column :calc_positions, :note, :string, limit: 255, default: ''
    add_column :calc_inventories, :note, :string, limit: 255, default: ''
    add_column :calc_equipments, :note, :string, limit: 255, default: ''
  end
end
