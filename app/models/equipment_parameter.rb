class EquipmentParameter < ApplicationRecord
  belongs_to :equipment
  validates :price, presence: true
  validates :lifetime, presence: true
  validates :power, presence: true

  scope :set_relevant, -> { last.update_column(:actual, true) }

  def self.get_last(equipment_id, number)
    joins(:equipment).where(equipment_id: equipment_id).order(created_at: :desc).limit(number)
  end

  def self.set_irrelevant(equipment_id)
    joins(:equipment).where(equipment_id: equipment_id).update_all(actual: false)
  end
end
