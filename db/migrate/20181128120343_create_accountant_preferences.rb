class CreateAccountantPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :accountant_preferences do |t|
      t.decimal :income_tax_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :eru_tax_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :manager_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :profit_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :overheads_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.decimal :tax_percent, precision: 5, scale: 2, null: false, default: 0.00
      t.boolean :actual, null: false, default: 1
      t.timestamps limit: 6, null: false
    end
  end
end
