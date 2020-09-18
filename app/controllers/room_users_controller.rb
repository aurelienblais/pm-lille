class RoomUsersController < ApplicationController
  expose :item, model: RoomUser, build_params: :room_user_params

  def new
    @room = Room.eager_load(room_users: :user).find(params[:room_id])
    @users = User.order_by_name - @room.room_users.flat_map(&:user)
    render 'ajax/new'
  end

  def create
    item.save!
  end

  private

  def room_user_params
    params.require(:room_user).permit(
      :room_id,
      :user_id
    )
  end
end
