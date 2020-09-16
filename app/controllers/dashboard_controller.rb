class DashboardController < ApplicationController
  def index
    @agents = Agent.order_by_name
    @current_date = Date.today
    @date_range = @current_date.beginning_of_month..@current_date.end_of_month

  end
end
