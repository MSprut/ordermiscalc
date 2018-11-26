class Equipment < ApplicationRecord
  has_many :equipment_parameters
  accepts_nested_attributes_for :equipment_parameters

  validates :name, presence: true
end
