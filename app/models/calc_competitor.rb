class CalcCompetitor < ApplicationRecord
  belongs_to :competitor
  accepts_nested_attributes_for :competitor
end
