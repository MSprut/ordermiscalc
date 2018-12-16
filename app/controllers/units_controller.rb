class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  # GET /units
  # GET /units.json
  def index
    @units = Unit.where(deleted: false).order(name: :asc)
  end

  # GET /units/1
  # GET /units/1.json
  def show; end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit; end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        flash[:success] = 'Единица измерения успешно создана.'
        format.html { redirect_to edit_unit_path(@unit) }
        format.json { render :show, status: :created, location: @unit }
      else
        flash[:danger] = 'Ошибка создания единицы измерения.'
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        flash[:success] = 'Единица измерения успешно обновлена.'
        format.html { redirect_to edit_unit_path(@unit) }
        format.json { render :show, status: :ok, location: @unit }
      else
        flash[:danger] = 'Ошибка обновления единицы измерения.'
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.update_column(:deleted, true)
    respond_to do |format|
      flash[:success] = 'Единица измерения успешно удалена.'
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:name)
    end
end
