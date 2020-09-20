# frozen_string_literal: true

class UsersController < ApplicationController
  expose :items, -> { policy_scope(User).eager_load(:teams).order_by_name.page params[:page] }
  expose :item, model: User, build_params: :user_params

  def index
    authorize User
  end

  def edit
    authorize item
    @teams = policy_scope(Team).order_by_name
    render 'ajax/edit'
  end

  def update
    authorize item

    team_ids = params[:user].delete(:team_ids)
    item.user_teams.destroy_all

    team_ids.each do |team_id|
      UserTeam.create(user: item, team_id: team_id)
    end

    item.update! user_params
    render 'ajax/update'
  end

  def reset_password
    @new_password = SecureRandom.hex(4)
    item.update(password: @new_password, password_confirmation: @new_password)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role
    )
  end
end
