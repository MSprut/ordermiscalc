class CalcEquipment < ApplicationRecord
  belongs_to :calculation
  belongs_to :equipment_parameter
  accepts_nested_attributes_for :equipment_parameter
end
