class Inventory < ApplicationRecord
  has_many :inventory_parameters
  accepts_nested_attributes_for :inventory_parameters

  belongs_to :unit

  validates :name, presence: true
end
