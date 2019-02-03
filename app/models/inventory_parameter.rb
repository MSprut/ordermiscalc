class InventoryParameter < ApplicationRecord
  belongs_to :inventory
  validates :price, presence: true

  scope :set_relevant, -> { last.update_column(:actual, true) }

  def self.get_last(inventory_id, number)
    joins(:inventory).where(inventory_id: inventory_id).order(created_at: :desc).limit(number)
  end

  def self.set_irrelevant(inventory_id)
    joins(:inventory).where(inventory_id: inventory_id).update_all(actual: false)
  end

  def self.set_actual
    order(created_at: :desc).limit(1).update(actual: true)
  end
end
