class CompetitorsController < ApplicationController
  before_action :set_competitor, only: [:show, :edit, :update, :destroy]

  # GET /competitors
  # GET /competitors.json
  def index
    @competitors = Competitor.where(deleted: false).order(name: :asc)
  end

  # GET /competitors/1
  # GET /competitors/1.json
  def show
  end

  # GET /competitors/new
  def new
    @competitor = Competitor.new
  end

  # GET /competitors/1/edit
  def edit
    @competitor = Competitor.find(params[:id])
  end

  # POST /competitors
  # POST /competitors.json
  def create
    @competitor = Competitor.new(competitor_params)

    respond_to do |format|
      if @competitor.save
        flash[:success] = 'Конкурент успешно создан.'
        format.html { redirect_to edit_competitor_path(@competitor) }
      else
        flash[:danger] = 'Ошибка создания конкурента.'
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /competitors/1
  # PATCH/PUT /competitors/1.json
  def update
    respond_to do |format|
      if @competitor.update(customer_category_params)
        flash[:success] = 'Конкурент успешно отредактирован.'
        format.html { redirect_to edit_competitor_path(@competitor) }
      else
        flash[:danger] = 'Ошибка редактирования конкурента.'
        format.html { redirect_to edit_competitor_path(@competitor) }
      end
    end
  end

  # DELETE /competitors/1
  # DELETE /competitors/1.json
  def destroy
    @competitor.update_column(:deleted, true)
    respond_to do |format|
      flash[:success] = 'Конкурент успешно удален.'
      format.html { redirect_to competitors_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competitor
      @competitor = Competitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competitor_params
      params.require(:competitor).permit(:name)
    end
end
