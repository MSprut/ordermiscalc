module PositionsHelper
  require 'ostruct'

  def salary_income(salary, pref)
    salary.try(:salary).to_f * ( 1.0 + pref.income_tax_percent.to_f / 100)
  end

  def salary_eru(salary, pref)
    salary.try(:salary).to_f * ( 1.0 + pref.eru_tax_percent / 100)
  end

  def salary_total(salary, pref)
    salary.try(:salary).to_f * ( 1.0 + (pref.income_tax_percent + pref.eru_tax_percent) / 100)
  end

  def salary_rate(salary, pref)
    '%.2f' % ( salary_total(salary, pref) * 12 / 1987)
  end

  def salary_details(salary, pref)
    details = {}
    details.store(:income, '%.2f' % salary_income(salary, pref))
    details.store(:eru, '%.2f' % salary_eru(salary, pref))
    details.store(:total, '%.2f' % salary_total(salary, pref))
    details.store(:rate, '%.2f' % salary_rate(salary, pref))
    details = OpenStruct.new details
  end
end
