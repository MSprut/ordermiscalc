class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy, :remove_item]

  def index
    @equipments = Equipment.where(deleted: false).order(name: :asc)
  end

  def show
  end

  def new
    @equipment = Equipment.new
    @equipment.equipment_parameters.build
  end

  def edit
    @equipment = Equipment.find(params[:id])
    @equipment_parameters = EquipmentParameter.get_last(@equipment.id, 5)
  end

  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        EquipmentParameter.set_irrelevant(@equipment.id)
        @equipment.equipment_parameters.set_relevant
        flash[:success] = 'Оборудование успешно создано.'
        format.html { redirect_to edit_equipment_path(@equipment) }
      else
        flash[:danger] = 'Ошибка создания оборудования.'
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        EquipmentParameter.set_irrelevant(@equipment.id)
        @equipment.equipment_parameters.set_relevant
        flash[:success] = 'Оборудование успешно отредактировано.'
        format.html { redirect_to edit_equipment_path(@equipment) }
      else
        flash[:danger] = 'Ошибка редактирования оборудования.'
        format.html { redirect_to edit_equipment_path(@equipment) }
      end
    end
  end

  def destroy
    @equipment.update_column(:deleted, true)
    respond_to do |format|
      EquipmentParameter.set_irrelevant(@equipment.id)
      flash[:success] = 'Оборудование успешно удалено.'
      format.html { redirect_to equipment_index_path }
    end
  end

  def remove_item
    item = EquipmentParameter.find(params[:id])

    respond_to do |format|
      if item.destroy
        @equipment.set_actual_parameter
        flash[:success] = 'История успешно удалена.'
      else
        flash[:error] = 'Ошибка удаления истории.'
      end
      format.html { redirect_to edit_equipment_path(@equipment) }
    end
  end

  private

    def set_equipment
      id = params[:equipment_id].present? ? params[:equipment_id] : params[:id]
      @equipment = Equipment.find(id)
    end

    def equipment_params
      params.require(:equipment).permit(:name, equipment_parameters_attributes: [:id, :equipment_id, :price, :lifetime, :power, :actual, :residual_price, :standbay_power, :depreciation_type])
    end
end
