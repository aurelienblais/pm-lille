# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompensatoryRest, type: :model do
  subject { create(:compensatory_rest) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:agent) }
end
