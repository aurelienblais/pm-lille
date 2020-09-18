class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :order_by_name, -> { order(:first_name).order(:last_name) }

  after_create :join_default_room

  def complete_name
    "#{first_name} #{last_name}"
  end

  def gravatar_url
    gravatar_id = Digest::MD5.hexdigest(email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end

  private

  def join_default_room
    RoomUser.create!(room_id: ENV.fetch('DEFAULT_ROOM_ID', Room.first.id), user_id: id)
  end
end
