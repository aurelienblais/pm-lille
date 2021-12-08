# frozen_string_literal: true

class CompensatoryRestsController < ApplicationController
  expose :items, -> { policy_scope(CompensatoryRest).eager_load(:agent) }
  expose :item, model: CompensatoryRest, build_params: :compensatory_rest_params

  def index
    authorize CompensatoryRest
  end

  def new
    authorize item

    @agents = policy_scope(Agent).order_by_name

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

    render 'ajax/edit'
  end

  def update
    authorize item
    item.update! compensatory_rest_params
    render 'ajax/update'
  end

  def destroy
    authorize item
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def compensatory_rest_params
    params.require(:compensatory_rest).permit(
      :agent_id,
      :reason,
      :amount
    )
  end
end
