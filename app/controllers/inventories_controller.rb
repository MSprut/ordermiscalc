class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]

  def index
    @inventories = Inventory.where(deleted: false).order(name: :asc)
  end

  def show; end

  def new
    @inventory = Inventory.new
    @inventory.inventory_parameters.build
    @units = Unit.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
  end

  def edit
    @inventory = Inventory.find(params[:id])
    @inventory_parameters = InventoryParameter.get_last(@inventory.id, 5)
    @units = Unit.order(name: :asc).map { |u| [ u.name, u.id ] }
  end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        InventoryParameter.set_irrelevant(@inventory.id)
        @inventory.inventory_parameters.set_relevant
        flash[:success] = 'ТМЦ успешно создана.'
        format.html { redirect_to edit_inventory_path(@inventory) }
      else
        flash[:danger] = 'Ошибка создания ТМЦ.'
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        InventoryParameter.set_irrelevant(@inventory.id)
        @inventory.inventory_parameters.set_relevant
        flash[:success] = 'ТМЦ успешно отредактирована.'
        format.html { redirect_to edit_inventory_path(@inventory) }
      else
        flash[:danger] = 'Ошибка редактирования ТМЦ.'
        format.html { redirect_to edit_inventory_path(@inventory) }
      end
    end
  end

  def destroy
    @inventory.update_column(:deleted, true)
    respond_to do |format|
      InventoryParameter.set_irrelevant(@inventory.id)
      flash[:success] = 'ТМЦ успешно удалена.'
      format.html { redirect_to inventory_index_path }
    end
  end

  private

    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    def inventory_params
      params.require(:inventory).permit(:name, :unit_id, inventory_parameters_attributes: [:id, :inventory_id, :price, :margin, :actual])
    end
end
