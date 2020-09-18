class DashboardController < ApplicationController
  def index
    if params[:dates]
      dates = params[:dates].split(' - ')
      @date_range = Date.parse(dates[0])..Date.parse(dates[1])
    else
      @current_date = Date.today
      @date_range = @current_date.beginning_of_month..@current_date.end_of_month
    end

    @agents = Agent.eager_load(:team).merge(Team.order_by_name).order_by_name
    @agents = @agents.belong_to_team(params[:team_id]) unless params[:team_id].blank?

    @absences = Absence.eager_load(:agent, :absence_type).where(agent: @agents).within_range(@date_range)

    @absence_types = AbsenceType.order_by_name
    @teams = Team.order_by_name
  end
end
