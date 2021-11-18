# frozen_string_literal: true

class BroadcastsController < ApplicationController
  def index
    authorize Room
    @teams = policy_scope(Team)
  end

  def create
    authorize Room

    targets = if params['target'].reject(&:blank?).empty?
                policy_scope(Team).eager_load(:agents)
              else
                Team.eager_load(:agents).where(id: params['target'].reject(&:blank?))
              end

    Room.where(agent_id: targets.flat_map(&:agents).map(&:id)).each do |room|
      item = RoomMessage.create!(room: room, user: current_user, message: params['message'])
      AgentMailer.with(agent: room.agent, message: item).message_notification.deliver_now!
    end

    render 'broadcasts/create'
  end

  private

  def broadcast_params
    params.permit(
      :message,
      :target
    )
  end
end
