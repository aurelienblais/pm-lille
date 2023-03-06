# frozen_string_literal: true

class AbsenceTypesController < ApplicationController
  expose :items, -> { policy_scope(AbsenceType).order_by_name }
  expose :item, model: AbsenceType, build_params: :absence_type_params

  def index
    authorize AbsenceType
  end

  def new
    authorize item
    render 'ajax/new'
  end

  def create
    authorize item
    item.save!
    render 'ajax/create'
  end

  def edit
    authorize item
    render 'ajax/edit'
  end

  def update
    authorize item
    item.update! absence_type_params
    render 'ajax/update'
  end

  def destroy
    authorize item
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def absence_type_params
    params.require(:absence_type).permit(
      :name,
      :color,
      :leave_balance,
      :texture,
      :display_statistic,
      :status
    )
  end
end
