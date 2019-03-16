class CalcInventory < ApplicationRecord
  belongs_to :calculation
  belongs_to :inventory_parameter
  accepts_nested_attributes_for :inventory_parameter
end
