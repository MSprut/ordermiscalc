class CustomerCategory < ApplicationRecord
  has_many :customer_category_parameters
  accepts_nested_attributes_for :customer_category_parameters

  validates :name, presence: true
end
