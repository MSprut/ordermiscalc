class CustomerCategoriesController < ApplicationController
  before_action :set_customer_category, only: [:show, :edit, :update, :destroy, :restore]

  # GET /customer_categories
  # GET /customer_categories.json
  def index
    @customer_categories = CustomerCategory.where(deleted: false).order(name: :asc)
    @removed_customer_categories = CustomerCategory.where(deleted: true)
  end

  # GET /customer_categories/1
  # GET /customer_categories/1.json
  def show
  end

  # GET /customer_categories/new
  def new
    @customer_category = CustomerCategory.new
    @customer_category.customer_category_parameters.build
  end

  # GET /customer_categories/1/edit
  def edit
    @customer_category = CustomerCategory.find(params[:id])
    @customer_category_parameters = CustomerCategoryParameter.get_last(@customer_category.id, 5)
  end

  # POST /customer_categories
  # POST /customer_categories.json
  def create
    @customer_category = CustomerCategory.new(customer_category_params)

    respond_to do |format|
      if @customer_category.save
        CustomerCategoryParameter.set_irrelevant(@customer_category.id)
        @customer_category.customer_category_parameters.set_relevant
        flash[:success] = 'Категория успешно создана.'
        format.html { redirect_to edit_customer_category_path(@customer_category) }
      else
        flash[:danger] = 'Ошибка создания категории.'
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /customer_categories/1
  # PATCH/PUT /customer_categories/1.json
  def update
    respond_to do |format|
      if @customer_category.update(customer_category_params)
        CustomerCategoryParameter.set_irrelevant(@customer_category.id)
        @customer_category.customer_category_parameters.set_relevant
        flash[:success] = 'Категория успешно отредактирована.'
        format.html { redirect_to edit_customer_category_path(@customer_category) }
      else
        flash[:danger] = 'Ошибка редактирования категории.'
        format.html { redirect_to edit_customer_category_path(@customer_category) }
      end
    end
  end

  # DELETE /customer_categories/1
  # DELETE /customer_categories/1.json
  def destroy
    @customer_category.update_column(:deleted, true)
    CalcCategoryPercent.where(customer_category_id: @customer_category.id).destroy_all
    CalcPrice.where(customer_category_id: @customer_category.id).destroy_all

    respond_to do |format|
      #CustomerCategoryParameter.set_irrelevant(@customer_category.id)
      flash[:success] = 'Категория успешно удалено.'
      format.html { redirect_to customer_categories_path }
    end
  end

  def restore
    @customer_category.update_column(:deleted, false)
    respond_to do |format|
      @customer_category.customer_category_parameters.set_relevant
      flash[:success] = 'Категория успешно восстановлена.'
      format.html { redirect_to customer_categories_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_category
      @customer_category = CustomerCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_category_params
      params.require(:customer_category).permit(:name,
        customer_category_parameters_attributes: [:customer_category_id, :user_id, :manager_percent,
          :profit_percent, :overheads_percent, :tax_percent, :actual])
    end
end
