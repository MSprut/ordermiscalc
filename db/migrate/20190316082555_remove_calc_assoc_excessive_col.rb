class RemoveCalcAssocExcessiveCol < ActiveRecord::Migration[5.2]
  def change
    remove_column :calc_positions, :decimal
    remove_column :calc_inventories, :decimal
    remove_column :calc_equipments, :decimal
  end
end
