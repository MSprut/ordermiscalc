class CalcPrice < ApplicationRecord
  belongs_to :customer_category
  accepts_nested_attributes_for :customer_category
end
