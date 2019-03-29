class CalculationCategory < ApplicationRecord
  has_ancestry orphan_strategy: :rootify
  has_many :calculation_categories_calculations, :dependent => :destroy
  has_many :calculations, through: :calculation_categories_calculations
  has_many :calc_category_percents
  accepts_nested_attributes_for :calc_category_percents
end
