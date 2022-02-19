# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { is_expected.to be_valid }

  describe '#complete_name' do
    it 'returns user complete name' do
      expect(subject.complete_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end

  describe '#gravatar_url' do
    it 'returns a gravatar url' do
      expect(subject.gravatar_url).to match(/([a-z0-9]*).png/)
    end
  end

  describe '#active_for_authentication?' do
    context 'when user is not disabled' do
      it 'returns true' do
        expect(subject).to be_active_for_authentication
      end
    end

    context 'when user is disabled' do
      subject { create(:user, :disabled) }

      it 'returns false' do
        expect(subject).not_to be_active_for_authentication
      end
    end
  end

  describe '#disabled?' do
    context 'when user is disabled' do
      subject { create(:user, :disabled) }

      it 'returns true' do
        expect(subject).to be_disabled
      end
    end

    context 'when user is not disabled' do
      subject { create(:user) }

      it 'returns false' do
        expect(subject).not_to be_disabled
      end
    end
  end

  describe '#user?' do
    context 'when user is has role user' do
      subject { create(:user) }

      it 'returns true' do
        expect(subject).to be_user
      end
    end

    context 'when user is has another role' do
      subject { create(:user, :admin) }

      it 'returns false' do
        expect(subject).not_to be_user
      end
    end
  end

  describe '#admin?' do
    context 'when user is has role admin' do
      subject { create(:user, :admin) }

      it 'returns true' do
        expect(subject).to be_admin
      end
    end

    context 'when user is has another role' do
      subject { create(:user) }

      it 'returns false' do
        expect(subject).not_to be_admin
      end
    end
  end

  describe '#superadmin?' do
    context 'when user is has role superadmin' do
      subject { create(:user, :superadmin) }

      it 'returns true' do
        expect(subject).to be_superadmin
      end
    end

    context 'when user is has another role' do
      subject { create(:user) }

      it 'returns false' do
        expect(subject).not_to be_superadmin
      end
    end
  end
end
