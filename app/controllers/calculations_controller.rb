class CalculationsController < ApplicationController
  include PositionsHelper

  before_action :set_calculation, only: [:show, :edit, :update, :destroy]

  # GET /calculations
  # GET /calculations.json
  def index
    @calculations = Calculation.all
  end

  # GET /calculations/1
  # GET /calculations/1.json
  def show
  end

  # GET /calculations/new
  def new
    @calculation = Calculation.new
    create_nested_attributes
    preload_nested_params
  end

  # GET /calculations/1/edit
  def edit
    @calculation = Calculation.find(params[:id])
    create_nested_attributes
    preload_nested_params
  end

  # POST /calculations
  # POST /calculations.json
  def create
    @calculation = Calculation.new(calculation_params)
    preload_nested_params

    respond_to do |format|
      if @calculation.save
        if @calculation.update_attributes(category_params)
          flash[:success] = 'Калькуляция успешно создана.'
          format.html { redirect_to edit_calculation_path(@calculation) }
        end
      else
        flash[:danger] = 'Ошибка создания калькуляции.'
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /calculations/1
  # PATCH/PUT /calculations/1.json
  def update
    preload_nested_params

    respond_to do |format|
      if @calculation.update(calculation_params)
        flash[:success] = 'Калькуляция успешно отредактирована.'
        format.html { redirect_to edit_calculation_path(@calculation) }
        format.json { render :show, status: :ok, location: @calculation }
      else
        flash[:danger] = 'Ошибка редактирования калькуляции.'
        format.html { render :edit }
        format.json { render json: @calculation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculations/1
  # DELETE /calculations/1.json
  def destroy
    @calculation.destroy
    respond_to do |format|
      flash[:danger] = 'Калькуляция успешно удалена.'
      format.html { redirect_to calculation_categories_path }
      format.json { head :no_content }
    end
  end

  def get_unit_and_price
    #authorize :outdoor_advertising, :get_unit_and_price?
    if params[:selection] != ""
      case params[:block]
        when 'positions'
          salary = PositionSalary.find(params[:selection])
          prefs = AccountantPreference.find(salary.accountant_preference_id)
          @price = '%.4f' % salary_rate(salary, prefs)
        when 'inventories'
          object = InventoryParameter.find(params[:selection])
          @unit = object.inventory.unit.name
          @price = '%.4f' % object.price
        when 'equipments'
          object = EquipmentParameter.find(params[:selection])
          price = object.depreciation_type ? object.price - object.residual_price : object.price
          @price = '%.4f' % price
          @rate = '%.4f' % (price / object.lifetime / 168)
          @lifetime = object.lifetime
      end
    else
      @unit = ''
      @price = 0.00
      @lifetime = 0.00
    end

    @num = params[:num]
    @block = params[:block]

    respond_to do |f|
      f.js { render layout: false, content_type: 'text/javascript' }
      f.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculation_params
      params.require(:calculation).permit(:name, :price, #:calculation_category_ids,
        calc_positions_attributes: [:id, :calculation_id, :position_salary_id, :working_time, :time_coeff, :note, :_destroy],
        calc_inventories_attributes: [:id, :calculation_id, :inventory_parameter_id, :width, :length, :quantity, :note, :_destroy],
        calc_equipments_attributes: [:id, :calculation_id, :equipment_parameter_id, :usage_time, :note, :_destroy])
    end

    def category_params
      params.require(:calculation).permit(:calculation_category_ids)
    end

    def collection_for_parent_select
      ancestry_options(CalculationCategory.unscoped.arrange(order: 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
    end

    def ancestry_options(items)
      result = []
      items.map do |item, sub_items|
          result << [(("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" * item.depth) + item.name).html_safe, item.id]
          result += ancestry_options(sub_items) unless sub_items.blank?
      end
      result
    end

    def preload_nested_params
      @calculation_categories = collection_for_parent_select
      @inventory_parameters = InventoryParameter.where(actual: true).collect { |i| [ i.inventory.name, i.id ] }
      @position_salaries = PositionSalary.where(actual: true).collect { |p| [ p.position.name, p.id ] }
      @equipment_parameters = EquipmentParameter.where(actual: true).collect { |e| [ e.equipment.name, e.id ] }
      @customer_categories = CustomerCategory.where(deleted: false).order(name: :asc).all
    end

    def create_nested_attributes
      @calculation.calc_positions.build if @calculation.calc_positions.blank?
      @calculation.calc_inventories.build if @calculation.calc_inventories.blank?
      @calculation.calc_equipments.build if @calculation.calc_equipments.blank?
    end
end
