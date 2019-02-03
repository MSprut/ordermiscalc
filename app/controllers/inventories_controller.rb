class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy, :remove_item]

  def index
    @inventories = Inventory.where(deleted: false).order(name: :asc)
  end

  def show; end

  def new
    @inventory = Inventory.new
    @inventory.inventory_parameters.build
    @units = Unit.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventory_categories = collection_for_parent_select
  end

  def edit
    @inventory = Inventory.find(params[:id])
    @inventory_parameters = InventoryParameter.get_last(@inventory.id, 5)
    @units = Unit.order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventory_categories = collection_for_parent_select
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

  def remove_item
    item = InventoryParameter.find(params[:id])

    respond_to do |format|
      if item.destroy
        puts "\n" + 'INVENTORY= ' + @inventory.inspect + "\n\r"
        @inventory.set_actual_parameter
        flash[:success] = 'История успешно удалена.'
      else
        flash[:error] = 'Ошибка удаления истории.'
      end
      format.html { redirect_to edit_inventory_path(@inventory) }
    end
  end

  private

    def set_inventory
      id = params[:inventory_id].present? ? params[:inventory_id] : params[:id]
      @inventory = Inventory.find(id)
    end

    def inventory_params
      params.require(:inventory).permit(:name, :unit_id, inventory_parameters_attributes: [:id, :inventory_id, :price, :margin, :actual], inventory_category_ids: [])
    end

    def collection_for_parent_select
      @categories = ancestry_options(InventoryCategory.unscoped.arrange(order: 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
    end

    def ancestry_options(items)
    result = []
    items.map do |item, sub_items|
        result << [(("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" * item.depth) + item.name).html_safe, item.id]
        result += ancestry_options(sub_items) unless sub_items.blank?
    end
    result
  end
end
