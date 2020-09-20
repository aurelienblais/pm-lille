class Public::AgentsController < ApplicationController
  layout 'public'
  skip_before_action :authenticate_user!

  def show
    @agent = Agent.find_by(token: params[:id])

    @date_range = Date.today.beginning_of_year..Date.today.end_of_year
    @month_range = Date.today.beginning_of_month..Date.today.end_of_month

    @absences = Absence
                    .eager_load(:agent, :absence_type)
                    .within_range(@date_range)
                    .where(agent: @agent)

    @holidays = Holidays.between(@date_range.first, @date_range.last, :fr)
    @absence_types = AbsenceType.order_by_name

    @team_agents = Agent.belong_to_team(@agent.team_id).order_by_name.present_in_range(@month_range)
    @team_absences = Absence
                         .eager_load(:agent, :absence_type)
                         .where(agent: @agents)
                         .within_range(@month_range)

  end
end