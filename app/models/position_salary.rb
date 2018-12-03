class PositionSalary < ApplicationRecord
  belongs_to :position
  validates :salary, presence: true

  scope :set_relevant, -> { last.update_column(:actual, true) }
  scope :get_actual, -> { where(actual: true) }

  def self.get_last(position_id, number)
    joins(:position).where(position_id: position_id).order(created_at: :desc).limit(number)
  end

  def self.set_irrelevant(position_id)
    joins(:position).where(position_id: position_id).update_all(actual: false)
  end

  def self.set_previous_irrelevant(position_id)
    where.not(position_id: position_id).update_all(actual: false)
  end
end
