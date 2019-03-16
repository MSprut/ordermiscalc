class Position < ApplicationRecord
  has_many :calc_position
  has_many :position_salaries
  accepts_nested_attributes_for :position_salaries

  validates :name, presence: true
  validates :name, uniqueness: true

  def actual_salary
    position_salaries.where(actual: true).first
  end

  def get_pref_id
    actual_salary.accountant_preference_id
  end

  def actual_pref
    AccountantPreference.find(self.get_pref_id)
  end
end
