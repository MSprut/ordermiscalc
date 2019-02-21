class CreateCalculationCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :calculation_categories do |t|
      t.string :name, null: false, default: ''
      t.string :ancestry
      t.boolean :deleted, null: false, default: 0
      t.timestamps limit: 6, null: false
    end
    add_index :calculation_categories, :ancestry
  end
end
