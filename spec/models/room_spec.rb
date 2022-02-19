# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { create(:room) }

  it { is_expected.to be_valid }

  describe '#create_system_message' do
    context 'when room belongs to an agent' do
      subject { create(:room, :with_agent) }

      it 'contains no messages' do
        expect(subject.room_messages.count).to eq 0
      end
    end

    context 'when room does not belongs to an agent' do
      it 'contains one message' do
        expect(subject.room_messages.count).to eq 1
      end
    end
  end

  describe '#invite_users' do
    context 'when room belongs to an agent' do
      subject { create(:room, agent: agent) }

      let(:agent) { create(:agent) }
      let!(:user) { create(:user, :with_team, team: agent.team) }

      it 'invites team users' do
        expect(subject.users.count).to eq 1
      end
    end
  end
end
