require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'validations' do
    subject { build(:movie) }

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

    it 'is invalid without accessability' do
      subject.accessibility = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without the correct inclusion of 0 or 1 for accessability' do
      subject.accessibility = 2
      expect(subject).to be_invalid
    end
  end
end
