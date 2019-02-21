class Calculation < ApplicationRecord
  has_many :calculation_categories_calculations, :dependent => :destroy
  has_many :calculation_categories, through: :calculation_categories_calculations

  validates :name, presence: true
end
