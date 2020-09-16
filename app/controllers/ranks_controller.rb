class RanksController < ApplicationController
  expose :items, -> { Rank.eager_load(:agents).order_by_name }
  expose :item, model: Rank, build_params: :rank_params

  def index
  end

  def new
    render 'ajax/new'
  end

  def create
    item.save!
    render 'ajax/create'
  end

  def destroy
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