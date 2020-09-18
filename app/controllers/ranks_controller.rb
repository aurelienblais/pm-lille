# frozen_string_literal: true

class RanksController < ApplicationController
  expose :items, -> { policy_scope(Rank).eager_load(:agents).order_by_name }
  expose :item, model: Rank, build_params: :rank_params

  def index; end

  def new
    authorize item
    render 'ajax/new'
  end

  def create
    authorize item
    item.save!
    render 'ajax/create'
  end

  def destroy
    authorize item
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def rank_params
    params.require(:rank).permit(
      :name
    )
  end
end
