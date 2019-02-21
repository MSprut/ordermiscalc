class CalculationCategoriesController < ApplicationController
  before_action :set_calculation_category, only: [:show, :edit, :update, :destroy]

  # GET /calculation_categories
  # GET /calculation_categories.json
  def index
    @calculation_categories = CalculationCategory.all.arrange
  end

  # GET /calculation_categories/1
  # GET /calculation_categories/1.json
  def show
  end

  # GET /calculation_categories/new
  def new
    @calculation_category = CalculationCategory.new
    @calculation_categories = collection_for_parent_select
    #@calculations = Calculation.joins(:calculation_categories_calculations)
    #  .where(calculation_categories_calculations: {calculation_id: nil})
    #  .where(deleted: false)
    #  .order(name: :asc)
    #  .map { |u| [ u.name, u.id ] }
  end

  # GET /calculation_categories/1/edit
  def edit
    @calculation_categories = collection_for_parent_select
    #@calculations = Calculation.includes(:calculation_categories_calculations)
    #  .where(deleted: false)
    #  .order(name: :asc)
    #  .map { |u| [ u.name, u.id ] }
  end

  # POST /calculation_categories
  # POST /calculation_categories.json
  def create
    @calculation_category = CalculationCategory.new(calculation_category_params)
    @calculation_categories = CalculationCategory.order(name: :asc).map { |u| [ u.name, u.id ] }
    #@calculations = Calculation.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    respond_to do |format|
      if @calculation_category.save
        flash[:success] = 'Категория калькуляций успешно создана.'
        format.html { redirect_to edit_calculation_category_path(@calculation_category) }
        format.json { render :show, status: :created, location: @calculation_category }
      else
        flash[:danger] = 'Ошибка создания категории калькуляций'
        format.html { render :new }
        format.json { render json: @calculation_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calculation_categories/1
  # PATCH/PUT /calculation_categories/1.json
  def update
    @calculation_categories = CalculationCategory.order(name: :asc).map { |u| [ u.name, u.id ] }
    #@calculations = Calculation.where(deleted: false).order(name: :asc).map { |u| [ u.name, u.id ] }
    respond_to do |format|
      if @calculation_category.update(calculation_category_params)
        flash[:success] = 'Категория калькуляций успешно отредактирована.'
        format.html { redirect_to edit_calculation_category_path(@calculation_category) }
        format.json { render :show, status: :ok, location: @calculation_category }
      else
        flash[:danger] = 'Ошибка редактирования категории калькуляций'
        format.html { render :edit }
        format.json { render json: @calculation_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculation_categories/1
  # DELETE /calculation_categories/1.json
  def destroy
    @calculation_category.destroy
    respond_to do |format|
      flash[:success] = 'Категория калькуляций успешно удалена'
      format.html { redirect_to calculation_categories_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation_category
      @calculation_category = CalculationCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculation_category_params
      params.require(:calculation_category).permit(:name, :parent_id)
    end

    def collection_for_parent_select
      @categories = ancestry_options(CalculationCategory.unscoped.arrange(order: 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
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
