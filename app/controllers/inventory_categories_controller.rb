class InventoryCategoriesController < ApplicationController
  before_action :set_inventory_category, only: [:show, :edit, :update, :destroy]

  # GET /inventory_categories
  # GET /inventory_categories.json
  def index
    @inventory_categories = InventoryCategory.all.arrange
  end

  # GET /inventory_categories/1
  # GET /inventory_categories/1.json
  def show
  end

  # GET /inventory_categories/new
  def new
    @inventory_category = InventoryCategory.new
    @inventory_categories = collection_for_parent_select
    #@inventory_categories = InventoryCategory.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventories = Inventory.joins(:inventory_categories_inventories).where(inventory_categories_inventories: {inventory_id: nil}).where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
  end

  # GET /inventory_categories/1/edit
  def edit
    #@inventory_categories = InventoryCategory.order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventory_categories = collection_for_parent_select
    @inventories = Inventory.includes(:inventory_categories_inventories).where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
  end

  # POST /inventory_categories
  # POST /inventory_categories.json
  def create
    @inventory_category = InventoryCategory.new(inventory_category_params)
    @inventory_categories = InventoryCategory.order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventories = Inventory.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    respond_to do |format|
      if @inventory_category.save
        flash[:success] = 'Категория ТМЦ успешно создана.'
        format.html { redirect_to edit_inventory_category_path(@inventory_category) }
        format.json { render :show, status: :created, location: @inventory_category }
      else
        flash[:danger] = 'Ошибка создания категории ТМЦ'
        format.html { render :new }
        format.json { render json: @inventory_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_categories/1
  # PATCH/PUT /inventory_categories/1.json
  def update
    @inventory_categories = InventoryCategory.order(name: :asc).map { |u| [ u.name, u.id ] }
    @inventories = Inventory.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    respond_to do |format|
      if @inventory_category.update(inventory_category_params)
        flash[:success] = 'Категория ТМЦ успешно отредактирована.'
        format.html { redirect_to edit_inventory_category_path(@inventory_category) }
        format.json { render :show, status: :ok, location: @inventory_category }
      else
        flash[:danger] = 'Ошибка редактирования категории ТМЦ'
        format.html { render :edit }
        format.json { render json: @inventory_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_categories/1
  # DELETE /inventory_categories/1.json
  def destroy
    @inventory_category.destroy
    respond_to do |format|
      flash[:success] = 'Категория ТМЦ успешно удалена'
      format.html { redirect_to inventory_categories_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_category
      @inventory_category = InventoryCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_category_params
      params.require(:inventory_category).permit(:name, :parent_id, inventory_ids: [])
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
