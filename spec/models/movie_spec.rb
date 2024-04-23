require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'validations' do
    let(:user) { create(:user) }
    subject { build(:movie, user: user) }

    it 'is valid with all attributes set' do
      expect(subject).to be_valid
    end

    it 'is invalid without user reference' do
      subject.user_id = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without accessibility' do
      subject.accessibility = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without the correct inclusion of 0 or 1 for accessibility' do
      subject.accessibility = 2
      expect(subject).to be_invalid
    end
  end
end
