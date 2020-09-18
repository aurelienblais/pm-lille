# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @month_range = Date.current.beginning_of_month..Date.current.end_of_month
    @year_range = Date.current.beginning_of_year..Date.current.end_of_year

    @birthdays = Agent
                 .birthdays_in_range(@month_range)
                 .page(params[:page])
                 .per(5)

    @room_id = ENV.fetch('DEFAULT_ROOM_ID', Room.first.id)
    @last_messages = RoomMessage.eager_load(:user).for_room(@room_id).latest(5)

    @month_absences = Absence
                      .eager_load(:absence_type)
                      .within_range(@month_range)
                      .group_by { |item| item.absence_type.name }
                      .transform_values(&:length)

    @year_absences = Absence
                     .eager_load(:absence_type)
                     .within_range(@year_range)
                     .group_by { |item| item.absence_type.name }
                     .transform_values(&:length)
  end
end
