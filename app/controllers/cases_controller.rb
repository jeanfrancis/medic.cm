class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  def index
    @cases = Case.all
  end

  def show
  end

  def new
    @active_case = current_user.cases.where(status: 'active').take
    @closed_cases = current_user.cases.where(status: 'closed')
  end

  def create
    @case = Case.new(case_params)
    @case.patient_id = current_user.id
    @case.status = 'active'
    respond_to do |format|
      if @case.save
        format.html { redirect_to new_case_path, notice: 'Case was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    current_user.active_case.destroy
    redirect_to new_case_path
  end

  private
    def set_case
      @case = Case.find(params[:id])
    end

    def case_params
      params.require(:case).permit(:description, :solution, :specialist_type)
    end
end
