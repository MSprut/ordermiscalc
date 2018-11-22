class CreatePositionSalaries < ActiveRecord::Migration[5.2]
  def change
    create_table :position_salaries do |t|
      t.references :position
      t.decimal :salary, precision: 10, scale: 2, null: false, default: 0.00
      t.boolean :actual, null: false, default: 1
      t.timestamps limit: 6, null: false
    end
  end
end
