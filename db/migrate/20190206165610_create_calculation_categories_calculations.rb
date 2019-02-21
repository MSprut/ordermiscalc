class CreateCalculationCategoriesCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :calculation_categories_calculations do |t|
      t.references :calculation_category, index: { name: 'index_calc_cats_calcs_on_calc_cat_id' }
      t.references :calculation, index: { name: 'index_calc_cats_calcs_on_calc_id' }
      t.timestamps limit: 6, null: false
    end
  end
end
