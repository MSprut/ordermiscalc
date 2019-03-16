class Calculation < ApplicationRecord

  validates :name, presence: true

  #----- POSITIONS -------------------------------------
  has_many :calc_positions, :dependent => :destroy
  accepts_nested_attributes_for :calc_positions,
    :reject_if => lambda { |a| a[:position_salary_id].blank? }, :allow_destroy => true

  #----- INVENTORIES -------------------------------------
  has_many :calc_inventories, :dependent => :destroy
  accepts_nested_attributes_for :calc_inventories,
    :reject_if => lambda { |a| a[:inventory_parameter_id].blank? }, :allow_destroy => true

  #----- EQUIPMENTS -------------------------------------
  has_many :calc_equipments, :dependent => :destroy
  accepts_nested_attributes_for :calc_equipments,
    :reject_if => lambda { |a| (a[:equipment_parameter_id].blank?) }, :allow_destroy => true

  has_many :calculation_categories_calculations, :dependent => :destroy
  has_many :calculation_categories, through: :calculation_categories_calculations
end
