# frozen_string_literal: true

class AgentsController < ApplicationController
  expose :item, model: Agent, build_params: :agent_params

  def index
    @agents = policy_scope(Agent)
                .eager_load(:team, :rank, :compensatory_rests)
                .order_by_name

    unless params[:show_all]
      @agents = @agents.present_in_range(7.days.ago .. 7.days.from_now)
    end

    @agents = @agents.page params[:page]
  end

  def new
    authorize item
    @teams = policy_scope(Team).order_by_name
    render 'ajax/new'
  end

  def show
    authorize item
    @current_date = params[:year] ? Date.parse("01-01-#{params[:year]}") : Time.zone.today

    @date_range = @current_date.all_year
    @last_year_range = (@date_range.first - 1.year).beginning_of_year..(@date_range.last - 1.year).end_of_year

    @absences = Absence
      .eager_load(:agent, :absence_type)
      .within_range(@date_range)
      .where(agent: item)

    @holidays = Holidays.between(@date_range.first, @date_range.last, :fr)
    @recurring_absences = RecurringAbsence
      .eager_load(:agent, :absence_type)
      .where(agent: item)
      .flat_map { |ra| ra.for_range(@date_range) }.compact

    @leave_taken = item.leave_balance_for_range @date_range
    @leave_outstanding = item.leave_balance_for_range @last_year_range

    @compensatory_rests = CompensatoryRest.eager_load(:agent).where(agent: item).page params[:page]

    @absence_types = AbsenceType.visible.order_by_name
  end

  def create
    authorize item
    item.save!
    render 'ajax/create'
  end

  def edit
    authorize item
    @teams = policy_scope(Team).order_by_name
    render 'ajax/edit'
  end

  def update
    authorize item
    item.update agent_params
    render 'ajax/update'
  end

  def destroy
    authorize item
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
      :rank_id,
      :leave_balance,
      :token,
      :email
    )
  end
end
