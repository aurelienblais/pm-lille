# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecurringAbsence, type: :model do
  subject { create(:recurring_absence) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:agent) }
  it { is_expected.to belong_to(:absence_type) }

  describe '#for_range' do
    subject { create(:recurring_absence, start_date: range.first, end_date: range.last, periodicity: 5) }

    let(:range) { Date.new(2019, 0o1, 0o1)..Date.new(2019, 0o1, 31) }

    it 'returns absences' do
      expect(subject.for_range(range).count).to eq(7)
    end
  end
end
