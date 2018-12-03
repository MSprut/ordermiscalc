class AccountantPreferencesController < ApplicationController
  before_action :set_accountant_preference, only: [:show, :edit, :update, :destroy]

  def index
    @accountant_preferences = AccountantPreference.where(actual: true)
  end

  def show
  end

  def new
    @accountant_preference = AccountantPreference.new
    @accountant_preferences = AccountantPreference.get_last(5)
  end

  def edit
    @accountant_preference = AccountantPreference.find(params[:id])
    @accountant_preferences = AccountantPreference.get_last(5)
  end

  def create
    @accountant_preference = AccountantPreference.new(accountant_preference_params)

    respond_to do |format|
      if @accountant_preference.save
        @accountant_preference.set_previous_irrelevant#(@accountant_preference.id)
        #@accountant_preference.set_relevant
        flash[:success] = 'Настройки успешно созданы.'
        format.html { redirect_to edit_accountant_preference_path(@accountant_preference) }
      else
        flash[:danger] = 'Ошибка создания настроек.'
        format.html { render :new }
      end
    end
  end

  def update
    @accountant_preference = AccountantPreference.new(accountant_preference_params)
    respond_to do |format|
      if @accountant_preference.update(accountant_preference_params)
        @accountant_preference.set_previous_irrelevant#(@accountant_preference.id)
        #@accountant_preference.set_relevant
        flash[:success] = 'Настройки успешно отредактирована.'
        format.html { redirect_to edit_accountant_preference_path(@accountant_preference) }
      else
        flash[:danger] = 'Ошибка редактирования настроек.'
        format.html { redirect_to edit_accountant_preference_path(@accountant_preference) }
      end
    end
  end

  def destroy
    @accountant_preference.destroy_active
    respond_to do |format|
      format.html { redirect_to accountant_preferences_url, notice: 'Настройки успешно удалены.' }
      format.json { head :no_content }
    end
  end

  private
    def set_accountant_preference
      @accountant_preference = AccountantPreference.find(params[:id])
    end

    def accountant_preference_params
      params.require(:accountant_preference).permit(:income_tax_percent, :eru_tax_percent,
        :profit_percent, :manager_percent, :overheads_percent, :tax_percent)
    end
end
