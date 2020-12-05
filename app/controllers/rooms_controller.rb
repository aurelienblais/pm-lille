# frozen_string_literal: true

class RoomsController < ApplicationController
  expose :items, -> { policy_scope(Room).includes(:room_messages).order_by_last_message.order_by_name }
  expose :item, model: Room, build_params: :room_params

  def index; end

  def show
    authorize item
    @room_message = RoomMessage.new room: item
    @room_messages = policy_scope(RoomMessage).includes(:user).where(room: item)
  end

  def new
    authorize item
    render 'ajax/new'
  end

  def create
    authorize item
    item.save!
    RoomUser.create(room: item, user: current_user)
    redirect_to item
  rescue ActiveRecord::RecordNotUnique
    @error_message = "Une salle ayant le nom #{room_params[:name]} existe déjà."
    render 'error/duplicate'
  end

  def purge
    authorize item
    item.room_messages.find_each do |room_message|
      room_message.destroy
      RoomChannel.broadcast_to item, room_message
    end
  end

  private

  def room_params
    params.require(:room).permit(
      :name
    )
  end
end
