require 'rails_helper'

RSpec.describe FormatPasswordValidator do
  before do
    stub_const('FormatPasswordValidable', ValidatorsHelpers::FakeFormatPasswordValidable)
  end

  subject { FormatPasswordValidable.new }

  context 'when password follows a wrong format' do
    let(:password) { '1234' }

    it 'is invalid record' do
      subject.password = password
      expect(subject).to_not be_valid
    end
  end

  context 'when password has a right format' do
    let(:password) { 'TestingOelo!' }

    it 'is valid' do
      subject.password = password
      expect(subject).to be_valid
    end
  end
end
