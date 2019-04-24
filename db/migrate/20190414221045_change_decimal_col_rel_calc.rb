class ChangeDecimalColRelCalc < ActiveRecord::Migration[5.2]
  def change
    rename_column :related_calculations, :decimal, :note
    change_column :related_calculations, :note, :string, limit: 255, default: ''
  end
end
