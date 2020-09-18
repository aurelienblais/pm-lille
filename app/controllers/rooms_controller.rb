class RoomsController < ApplicationController
  expose :items, -> { Room.for_user(current_user).includes(:room_messages).order_by_last_message.order_by_name }
  expose :item, model: Room, build_params: :room_params

  def index; end

  def show
    @room_message = RoomMessage.new room: item
    @room_messages = RoomMessage.includes(:user).where(room: item)
  end

  def new
    render 'ajax/new'
  end

  def create
    item.save!
    RoomUser.create(room: item, user: current_user)
    redirect_to item
  rescue ActiveRecord::RecordNotUnique
    @error_message = "Une salle ayant le nom #{room_params[:name]} existe déjà."
    render 'error/duplicate'
  end

  def destroy
    item.destroy!
    render 'ajax/destroy'
  end

  private

  def room_params
    params.require(:room).permit(
      :name
    )
  end
end
