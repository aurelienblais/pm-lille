# frozen_string_literal: true

class AbsencesController < ApplicationController
  def index
    authorize Absence

    if params[:dates]
      dates = params[:dates].split(' - ')
      @date_range = Date.parse(dates[0])..Date.parse(dates[1])
    else
      @current_date = Date.today
      @date_range = @current_date.beginning_of_month..@current_date.end_of_month
    end

    @agents = policy_scope(Agent).eager_load(:team).merge(Team.order_by_name).order_by_name
    @agents = @agents.belong_to_team(params[:team_id]) if params[:team_id].present?

    @absences = Absence.eager_load(:agent, :absence_type).where(agent: @agents).within_range(@date_range)

    @absence_types = AbsenceType.order_by_name
    @teams = policy_scope(Team).order_by_name
  end

  def create
    authorize Agent.find(absence_params[:agent_id]), :update?
    if absence_params[:absence_type_id].to_i.zero?
      absence = Absence.find_by absence_params.except(:absence_type_id)
      absence.destroy!
      head :ok
    else
      if Absence.create!(absence_params)
        head :ok
      else
        head :internal_server_error
      end
    end
  end

  private

  def absence_params
    params.require(:absence).permit(
      :agent_id,
      :absence_type_id,
      :date
    )
  end
end
