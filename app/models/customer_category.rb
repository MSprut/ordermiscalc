class CustomerCategory < ApplicationRecord
  has_many :customer_category_parameters
  accepts_nested_attributes_for :customer_category_parameters

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :not_deleted, -> { where(deleted: false) }
  scope :ordered_by_name, -> { order_by(name: :asc) }
end
