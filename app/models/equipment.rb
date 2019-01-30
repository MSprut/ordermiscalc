class Equipment < ApplicationRecord
  has_many :equipment_parameters
  accepts_nested_attributes_for :equipment_parameters

  validates :name, presence: true

  def set_actual_parameter
    parameters = self.equipment_parameters
    return unless parameters.present?
    
    actual_parameter = parameters.where(actual: true)
    return if actual_parameter.present?

    parameters.set_actual
  end
end
