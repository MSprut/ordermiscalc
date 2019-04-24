class Unit < ApplicationRecord
  has_many :inventories
  has_many :calculations
end
