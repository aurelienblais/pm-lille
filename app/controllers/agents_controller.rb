# frozen_string_literal: true

class AgentsController < ApplicationController
  expose :items, -> { policy_scope(Agent).eager_load(:team, :rank).order_by_name.page params[:page] }
  expose :item, model: Agent, build_params: :agent_params

  def index; end

  def new
    authorize item
    @teams = policy_scope(Team).order_by_name
    render 'ajax/new'
  end

  def show
    authorize item
    @current_date = params[:year] ? Date.parse("01-01-#{params[:year]}") : Date.today

    @date_range = @current_date.beginning_of_year..@current_date.end_of_year
    @last_year_range = (@current_date - 1.year).beginning_of_year..(@current_date - 1.year).end_of_year

    @absences = Absence
                .eager_load(:agent, :absence_type)
                .within_range(@date_range)
                .where(agent: item)

    @holidays = Holidays.between(@date_range.first, @date_range.last, :fr)

    @leave_taken = item.leave_balance_for_range @date_range
    @leave_outstanding = item.leave_balance_for_range @last_year_range

    @absence_types = AbsenceType.order_by_name
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
      :token
    )
  end
end
