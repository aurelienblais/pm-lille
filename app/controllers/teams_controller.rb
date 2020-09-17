class TeamsController < ApplicationController
  expose :items, -> { Team.eager_load(:agents).order_by_name }
  expose :item, model: Team, build_params: :team_params

  def index; end

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

  def team_params
    params.require(:team).permit(
      :name
    )
  end
end
