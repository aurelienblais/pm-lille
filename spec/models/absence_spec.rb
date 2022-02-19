# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Absence, type: :model do
  subject { create(:absence, date: Time.zone.today) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:agent) }
  it { is_expected.to belong_to(:absence_type) }

  it { is_expected.to validate_presence_of(:date) }

  describe '#to_json' do
    it 'returns a json string' do
      expect(subject.to_json).to include(
        subject.absence_type.name,
        Time.zone.today.to_s
      )
    end
  end
end
