class CreateCalcPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :calc_positions do |t|
      t.references :calculation
      t.references :position_salary
      t.decimal :working_time, :decimal, precision: 6, scale: 4, null: false, default: 0.00
      t.decimal :time_coeff, :decimal, precision: 5, scale: 4, null: false, default: 0.00
      t.timestamps limit: 6, null: false
    end
  end
end
