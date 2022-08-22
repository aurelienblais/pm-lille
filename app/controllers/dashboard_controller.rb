# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @month_range = Date.current.all_month
    @year_range = Date.current.all_year

    @agents = policy_scope(Agent).all
    @birthdays = @agents
      .birthdays_in_next_days(30)
      .page(params[:page])
      .per(5)

    @last_messages = policy_scope(RoomMessage).eager_load(:user, room: :agent).latest(10)

    @month_absences = policy_scope(Absence)
      .eager_load(:absence_type)
      .within_range(@month_range)
      .merge(AbsenceType.only_display_statistic)
      .where(agent: @agents)
      .group_by { |item| item.absence_type.name }
      .transform_values(&:length)

    @year_absences = policy_scope(Absence)
      .eager_load(:absence_type)
      .within_range(@year_range)
      .merge(AbsenceType.only_display_statistic)
      .where(agent: @agents)
      .group_by { |item| item.absence_type.name }
      .transform_values(&:length)
  end
end
