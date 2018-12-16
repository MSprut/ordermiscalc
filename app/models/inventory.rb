class Inventory < ApplicationRecord
  has_many :inventory_parameters
  accepts_nested_attributes_for :inventory_parameters

  belongs_to :unit

  has_many :inventory_categories_inventories, :dependent => :destroy
  has_many :inventory_categories, through: :inventory_categories_inventories

  validates :name, presence: true
end
