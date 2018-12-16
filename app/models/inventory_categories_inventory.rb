class InventoryCategoriesInventory < ApplicationRecord
  belongs_to :inventory_category
  belongs_to :inventory
end
