class AbsenceTypesController < ApplicationController
  expose :items, -> { AbsenceType.order_by_name }
  expose :item, model: AbsenceType, build_params: :absence_type_params

  def index; end

  def new
    render 'ajax/new'
  end

  def create
    item.save!
    render 'ajax/create'
  end

  def edit
    render 'ajax/edit'
  end

  def update
    item.update! absence_type_params
    render 'ajax/update'
  end

  def destroy
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def absence_type_params
    params.require(:absence_type).permit(
      :name,
      :color,
      :leave_balance
    )
  end
end
