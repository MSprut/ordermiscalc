class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.where(deleted: false)
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
    @position.position_salaries.build
  end

  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
    @position_salaries = PositionSalary.get_last(@position.id, 5)
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        PositionSalary.set_irrelevant(@position.id)
        @position.position_salaries.set_relevant
        flash[:success] = 'Должность успешно создана.'
        format.html { redirect_to edit_position_path(@position) }
        #format.json { render :show, status: :created, location: @position }
      else
        flash[:danger] = 'Ошибка создания должности.'
        format.html { render :new }
        #format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        PositionSalary.set_irrelevant(@position.id)
        @position.position_salaries.set_relevant
        flash[:success] = 'Должность успешно отредактирована.'
        format.html { redirect_to edit_position_path(@position) }
        #format.json { render :show, status: :ok, location: @position }
      else
        flash[:danger] = 'Ошибка редактирования должности'
        format.html { redirect_to edit_position_path(@position) }
        #format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.update_column(:deleted, true)
    respond_to do |format|
      flash[:success] = 'Должность успешно удалена.'
      format.html { redirect_to positions_url }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:name, position_salaries_attributes: [:id, :position_id, :salary, :actual])
    end
end
