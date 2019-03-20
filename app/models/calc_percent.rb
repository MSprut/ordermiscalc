class CalcPercent < ApplicationRecord
  #belongs_to :calculation
  belongs_to :customer_category_parameter
  accepts_nested_attributes_for :customer_category_parameter

  belongs_to :calculation_category
  accepts_nested_attributes_for :calculation_category
end
