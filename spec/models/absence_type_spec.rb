# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbsenceType, type: :model do
  subject { create(:absence_type) }

  it { is_expected.to be_valid }

  describe '#to_s' do
    it "returns the absence type's name" do
      expect(subject.to_s).to eq(subject.name)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation' do
      expect(subject.to_hash).to include(
        name: subject.name,
        color: subject.color,
        texture: subject.texture
      )
    end
  end
end
