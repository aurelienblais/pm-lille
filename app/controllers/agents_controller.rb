class AgentsController < ApplicationController
  expose :items, -> { Agent.eager_load(:team).order_by_name.page params[:page] }
  expose :item, model: Agent, build_params: :agent_params

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
    item.update agent_params
    render 'ajax/update'
  end

  def destroy
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def agent_params
    params.require(:agent).permit(
      :first_name,
      :last_name,
      :register_number,
      :birthday,
      :arrival_date,
      :departure_date,
      :team_id,
      :rank_id
    )
  end
end
