# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Agent, type: :model do
  subject { create(:agent) }

  it { is_expected.to be_valid }
  it { is_expected.not_to have_attributes(token: nil) }

  describe '#birthdays_in_next_days' do
    context 'when birthday is in range' do
      subject { create(:agent, birthday: Time.zone.today + 1.day) }

      it 'returns the agent' do
        expect(described_class.birthdays_in_next_days(5)).to include(subject)
      end
    end

    context 'when birthday is not in range' do
      subject { create(:agent, birthday: Time.zone.today + 7.days) }

      it 'returns the agent' do
        expect(described_class.birthdays_in_next_days(5)).not_to include(subject)
      end
    end
  end

  describe '#present_in_range' do
    let(:range) { Date.new(2019, 0o1, 0o1)..Date.new(2019, 12, 31) }

    context 'when agent is present in range' do
      subject { create(:agent, arrival_date: Date.new(2019, 0o1, 10)) }

      it 'returns the agent' do
        expect(described_class.present_in_range(range)).to include(subject)
      end
    end

    context 'when agent is not present in range' do
      subject { create(:agent, arrival_date: Date.new(2020, 0o1, 0o1)) }

      it 'returns the agent' do
        expect(described_class.present_in_range(range)).not_to include(subject)
      end
    end
  end

  describe '#age' do
    context 'when birthday already happened' do
      subject { create(:agent, birthday: Time.zone.today - 20.years) }

      it 'returns an integer' do
        expect(subject.age).to eq 20
      end
    end

    context 'when birthday will happen later' do
      subject { create(:agent, birthday: Time.zone.today - 20.years + 5.days) }

      it 'returns an integer' do
        expect(subject.age).to eq 19
      end
    end
  end

  describe '#leave_balance_for_range' do
    context 'when range is < 2020' do
      let(:range) { Date.new(2019, 0o1, 0o1)..Date.new(2019, 12, 31) }

      it 'returns leave_balance' do
        expect(subject.leave_balance_for_range(range)).to eq subject.leave_balance
      end
    end

    context 'when absences should decrease leave_balance' do
      let(:range) { Date.new(2021, 0o1, 0o1)..Date.new(2021, 12, 31) }
      let(:absence_type) { create(:absence_type, leave_balance: 1) }
      let!(:absence) { create(:absence, agent: subject, date: Date.new(2021, 0o6, 0o6), absence_type: absence_type) }

      it 'returns updated leave_balance' do
        expect(subject.leave_balance_for_range(range)).to eq 1
      end
    end

    context 'when absences should not decrease leave_balance' do
      let(:range) { Date.new(2021, 0o1, 0o1)..Date.new(2021, 12, 31) }
      let!(:absence) { create(:absence, agent: subject, date: Date.new(2021, 0o6, 0o6)) }

      it 'returns updated leave_balance' do
        expect(subject.leave_balance_for_range(range)).to eq 0
      end
    end
  end
end
