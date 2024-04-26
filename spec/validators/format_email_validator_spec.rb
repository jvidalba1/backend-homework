require 'rails_helper'

RSpec.describe FormatEmailValidator do
  before do
    stub_const('FormatEmailValidable', ValidatorsHelpers::FakeFormatEmailValidable)
  end

  subject { FormatEmailValidable.new }

  context 'when email follows a wrong format' do
    let(:email) { 'testing@' }

    it 'is invalid record' do
      subject.email = email
      expect(subject).to_not be_valid
    end
  end

  context 'when email has a right format' do
    let(:email) { 'testing_oelo@sample.com' }

    it 'is valid' do
      subject.email = email
      expect(subject).to be_valid
    end
  end
end
