# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { create(:team) }

  it { is_expected.to be_valid }

  describe '#to_s' do
    it "returns the absence type's name" do
      expect(subject.to_s).to eq(subject.name)
    end
  end
end
