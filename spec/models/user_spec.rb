require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    subject {
      build(:user)
    }

    it 'is valid with all attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without first name' do
      subject.first_name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without last name' do
      subject.last_name = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without email' do
      subject.email = nil
      expect(subject).to be_invalid
    end

    it 'is invalid without password' do
      subject.password = nil
      expect(subject).to be_invalid
    end

    it 'is valid without birthday' do
      subject.birthday = nil
      expect(subject).to be_valid
    end
  end
end
