class CreateCalcPercents < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_percents do |t|
      t.references :calculation_category
      t.decimal :manager_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :profit_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :overheads_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
