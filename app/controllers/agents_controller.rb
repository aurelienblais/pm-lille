class AgentsController < ApplicationController
  expose :items, -> { Agent.eager_load(:team, :rank).order_by_name.page params[:page] }
  expose :item, model: Agent, build_params: :agent_params

  def index; end

  def new
    render 'ajax/new'
  end

  def show
    @current_date = params[:year] ? Date.parse("01-01-#{params[:year]}") : Date.today

    @date_range = @current_date.beginning_of_year..@current_date.end_of_year
    @last_year_range = (@current_date - 1.year).beginning_of_year..(@current_date - 1.year).end_of_year

    @absences = Absence
                .eager_load(:agent, :absence_type)
                .within_range(@date_range)
                .where(agent: item)

    @leave_taken = item.leave_balance_for_range @date_range
    @leave_outstanding = item.leave_balance_for_range @last_year_range

    @absence_types = AbsenceType.order_by_name
  end

  def create
    item.save!
    render 'ajax/create'
  end

  def edit
    render 'ajax/edit'
  end

  def update
    item.update agent_params
    render 'ajax/update'
  end

  def destroy
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
      :leave_balance
    )
  end
end
