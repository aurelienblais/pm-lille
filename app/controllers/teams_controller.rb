# frozen_string_literal: true

class TeamsController < ApplicationController
  expose :items, -> { policy_scope(Team).eager_load(:agents).order_by_name }
  expose :item, model: Team, build_params: :team_params

  def index
    authorize Team
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

  def destroy
    authorize item
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def team_params
    params.require(:team).permit(
      :name
    )
  end
end
