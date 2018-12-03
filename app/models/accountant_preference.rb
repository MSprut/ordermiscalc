class AccountantPreference < ApplicationRecord
  validates :income_tax_percent, presence: true
  validates :eru_tax_percent, presence: true
  validates :profit_percent, presence: true
  validates :tax_percent, presence: true
  validates :manager_percent, presence: true
  validates :overheads_percent, presence: true

  scope :set_relevant, -> { last.update_column(:actual, true) }

  def self.get_last(number)
    order(created_at: :desc).limit(number)
  end

  def set_previous_irrelevant
    AccountantPreference.where.not(id: self.id).update_all(actual: false)
  end

  def destroy_active
    update_column(:actual, false)
  end
end
