class AddCustomerCatToCalcCat < ActiveRecord::Migration[5.2]
  def change
    add_reference :calc_category_percents, :customer_category, foreign_key: true
  end
end
