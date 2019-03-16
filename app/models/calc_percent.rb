class CalcPercent < ApplicationRecord
  belongs_to :calculation
  has_many :customer_category_parameters
  accepts_nested_attributes_for :customer_category_parameters
end
