# frozen_string_literal: true

class RecurringAbsencesController < ApplicationController
  expose :items, -> { policy_scope(RecurringAbsence).eager_load(:agent, :absence_type) }
  expose :item, model: RecurringAbsence, build_params: :recurring_absence_params

  def index
    authorize RecurringAbsence
  end

  def new
    authorize item

    @agents = policy_scope(Agent).order_by_name
    @absence_types = AbsenceType.order_by_name

    render 'ajax/new'
  end

  def create
    authorize item
    item.save!
    render 'ajax/create'
  end

  def edit
    authorize item

    @agents = policy_scope(Agent).order_by_name
    @absence_types = AbsenceType.order_by_name

    render 'ajax/edit'
  end

  def update
    authorize item
    item.update! recurring_absence_params
    render 'ajax/update'
  end

  def destroy
    authorize item
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def recurring_absence_params
    params.require(:recurring_absence).permit(
      :agent_id,
      :absence_type_id,
      :start_date,
      :end_date,
      :periodicity
    )
  end
end
