class CustomerCategoryParameter < ApplicationRecord
  belongs_to :customer_category
  validates :manager_percent, presence: true
  validates :profit_percent, presence: true
  validates :overheads_percent, presence: true
  validates :tax_percent, presence: true

  scope :set_relevant, -> { last.update_column(:actual, true) }
  scope :get_actual, -> { where(actual: true) }

  def self.get_last(customer_category_id, number)
    joins(:customer_category).where(customer_category_id: customer_category_id).order(created_at: :desc).limit(number)
  end

  def self.set_irrelevant(customer_category_id)
    joins(:customer_category).where(customer_category_id: customer_category_id).update_all(actual: false)
  end
end
