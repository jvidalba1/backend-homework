require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
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

    it 'is invalid with wrong email format' do
      subject.email = 'testing_oelo.co'
      expect(subject).to be_invalid
    end

    it 'is invalid with an email already taken' do
      old_user = create(:user)
      subject.email = old_user.email

      expect(subject).to be_invalid
    end

    it 'is invalid without one lower letter in password' do
      subject.password = 'ABCDEFGHIJ!'

      expect(subject).to be_invalid
    end

    it 'is invalid without one upper letter in password' do
      subject.password = 'abcdefghij!'

      expect(subject).to be_invalid
    end

    it 'is invalid without one special character (!,@,#,? or ]) in password' do
      subject.password = 'AbcdefghiJ'

      expect(subject).to be_invalid
    end

    it 'is invalid with less than 10 characters in password' do
      subject.password = 'ABCabc!'

      expect(subject).to be_invalid
    end
  end
end
