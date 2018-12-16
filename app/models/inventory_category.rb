class InventoryCategory < ApplicationRecord
  has_ancestry orphan_strategy: :rootify
  has_many :inventory_categories_inventories, :dependent => :destroy
  has_many :inventories, through: :inventory_categories_inventories
end
