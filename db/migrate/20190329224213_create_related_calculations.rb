class CreateRelatedCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :related_calculations do |t|
      t.references :calculation
      t.integer :related_calculation_id
      t.decimal :quantity, :decimal, precision: 12, scale: 6, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
