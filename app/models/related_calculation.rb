class RelatedCalculation < ApplicationRecord
  belongs_to :related_calculation, :class_name => "Calculation"
end
