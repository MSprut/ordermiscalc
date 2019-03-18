class AddColToCalcPerc < ActiveRecord::Migration[5.2]
  def change
    add_reference :calc_percents, :customer_category_parameter, foreign_key: true
  end
end
