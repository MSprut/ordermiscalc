class Position < ApplicationRecord
  has_many :position_salaries
  accepts_nested_attributes_for :position_salaries

  validates :name, presence: true
  validates :name, uniqueness: true
end
