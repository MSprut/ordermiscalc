class CalculationCategory < ApplicationRecord
  has_ancestry orphan_strategy: :rootify
  has_many :calculation_categories_calculations, :dependent => :destroy
  has_many :calculations, through: :calculation_categories_calculations
  belongs_to :calc_percents
end
