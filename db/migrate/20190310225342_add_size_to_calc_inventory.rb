class AddSizeToCalcInventory < ActiveRecord::Migration[5.2]
  def change
    add_column :calc_inventories, :width, :integer, null: false, default: 0
    add_column :calc_inventories, :length, :integer, null: false, default: 0
  end
end
