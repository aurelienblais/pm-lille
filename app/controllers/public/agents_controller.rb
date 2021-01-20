# frozen_string_literal: true

module Public
  class AgentsController < ApplicationController
    layout 'public'
    skip_before_action :authenticate_user!

    def show
      @agent = Agent.eager_load(team: :agents).find_by(token: params[:id])

      @date_range = Date.today.beginning_of_year..Date.today.end_of_year
      @month_range = Date.today..(Date.today + 25.days)

      @absences = Absence
                  .eager_load(:agent, :absence_type)
                  .within_range(@date_range)
                  .where(agent: @agent)

      @holidays = Holidays.between(@date_range.first, @date_range.last, :fr)
      @absence_types = AbsenceType.order_by_name
      @recurring_absences = RecurringAbsence
                            .eager_load(:agent, :absence_type)
                            .where(agent: @agent)
                            .flat_map { |ra| ra.for_range(@date_range) }.compact

      @team_agents = @agent.team.agents.order_by_name.present_in_range(@month_range)
      @team_absences = Absence
                       .eager_load(:agent, :absence_type)
                       .where(agent: @team_agents)
                       .within_range(@month_range)

      @room = Room.find_or_create_by!(agent: @agent, name: @agent.complete_name)
    end
  end
end
