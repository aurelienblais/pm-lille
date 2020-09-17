class DashboardController < ApplicationController
  def index
    if params[:dates]
      dates = params[:dates].split(' - ')
      @date_range = Date.parse(dates[0])..Date.parse(dates[1])
    else
      @current_date = Date.today
      @date_range = @current_date.beginning_of_month..@current_date.end_of_month
    end

    @agents = Agent.order_by_name
    @absences = Absence.eager_load(:agent, :absence_type).within_range(@date_range)
    @absence_types = AbsenceType.order_by_name
  end
end
