# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomMessage, type: :model do
  subject { create(:room_message) }

  it { is_expected.to be_valid }

  describe '#get_user' do
    context 'when message belongs to a user' do
      subject { create(:room_message, :with_user) }

      it 'returns the user' do
        expect(subject.get_user).to eq(subject.user)
      end
    end

    context 'when message does not belongs to a user' do
      context 'when room belongs to an agent' do
        subject { create(:room_message, :with_agent) }

        it 'returns an object for the agent' do
          expect(subject.get_user).to have_attributes(
            complete_name: subject.room.agent.complete_name,
            gravatar_url: /(.*)agent(.*).jpg/
          )
        end
      end

      context 'when room does not belongs to an agent' do
        subject { create(:room_message) }

        it 'returns an object for the system' do
          expect(subject.get_user).to have_attributes(
            complete_name: 'Système',
            gravatar_url: /(.*)logo(.*).jpg/
          )
        end
      end
    end
  end
end
