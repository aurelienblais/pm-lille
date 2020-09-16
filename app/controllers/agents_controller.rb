class AgentsController < ApplicationController
  def index
    @agents = Agent.order_by_name
  end

  def create
    @agent = Agent.create(agent_params)
  end

  private

  def agent_params
    params.require(:agent).permit(
        :first_name,
        :last_name,
        :register_number,
        :birthday,
        :arrival_date,
        :departure_date
    )
  end
end