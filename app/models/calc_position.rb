class CalcPosition < ApplicationRecord
  belongs_to :calculation
  belongs_to :position_salary
  accepts_nested_attributes_for :position_salary
end
