# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :user_teams, dependent: :destroy
  has_many :teams, through: :user_teams
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  scope :order_by_name, -> { order(:first_name).order(:last_name) }

  ROLES = %i[disabled user admin superadmin].freeze

  after_create :join_default_room
  after_update :join_agents_rooms

  ROLES.each do |r|
    define_method "#{r}?" do
      role.to_sym == r
    end
  end

  def complete_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end

  def active_for_authentication?
    super && !disabled?
  end

  private

  def join_default_room
    RoomUser.create!(room_id: ENV.fetch('DEFAULT_ROOM_ID', Room.first.id), user_id: id)
  end

  def join_agents_rooms
    joined_rooms = rooms.where.not(agent_id: nil)
    room_users.where(room: joined_rooms).destroy_all

    agents = teams.flat_map(&:agents)
    Room.where(agent: agents).find_each do |room|
      RoomUser.create!(room:, user: self)
    end
  end
end
