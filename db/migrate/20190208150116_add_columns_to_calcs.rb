class AddColumnsToCalcs < ActiveRecord::Migration[5.2]
  def change
    add_column :calculations, :name, :string, null: false, default: ''
    add_column :calculations, :price, :decimal, precision: 10, scale: 2, null: false, default: 0.00
    add_column :calculations, :deleted, :boolean, null: false, default: 0
  end
end
