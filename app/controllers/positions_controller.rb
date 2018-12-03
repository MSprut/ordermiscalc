class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  def index
    @positions = Position.where(deleted: false).order(name: :asc)
    @accountant_preferences = AccountantPreference.all || AccountantPreference.new
  end

  def show; end

  def new
    @position = Position.new
    @position.position_salaries.build
    @accountant_preference = AccountantPreference.where(actual: true)
  end

  def edit
    @position = Position.find(params[:id])
    @position_salaries = PositionSalary.get_last(@position.id, 5)
    @accountant_preference = AccountantPreference.where(id: @position_salaries.last.accountant_preference_id).or(AccountantPreference.where(actual: true))
  end

  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        PositionSalary.set_irrelevant(@position.id)
        @position.position_salaries.set_relevant
        flash[:success] = 'Должность успешно создана.'
        format.html { redirect_to edit_position_path(@position) }
      else
        flash[:danger] = 'Ошибка создания должности.'
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update(position_params)
        PositionSalary.set_irrelevant(@position.id)
        @position.position_salaries.set_relevant
        flash[:success] = 'Должность успешно отредактирована.'
        format.html { redirect_to edit_position_path(@position) }
      else
        flash[:danger] = 'Ошибка редактирования должности.'
        format.html { redirect_to edit_position_path(@position) }
      end
    end
  end

  def destroy
    @position.update_column(:deleted, true)
    respond_to do |format|
      PositionSalary.set_irrelevant(@position.id)
      flash[:success] = 'Должность успешно удалена.'
      format.html { redirect_to positions_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:name,
        position_salaries_attributes: [:id, :position_id, :salary, :actual, :accountant_preference_id])
    end
end
