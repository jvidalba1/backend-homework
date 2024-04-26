require 'rails_helper'

RSpec.describe AuthenticationService do
  subject { described_class.new(email, password).call }
  let(:email) { 'testing_oelo@sample.com' }
  let(:password) { 'TestingOelo!' }

  describe 'Response' do
    context 'when there is a response' do
      it 'returns an ApplicationService::Response object' do
        expect(subject).to be_a(ApplicationService::Response)
      end
    end
  end

  describe 'Errors' do
    context 'when JWT encode error' do
      let!(:user) { create(:user, email: email, password: password) }
      let(:msg_error) { 'encoding jwt error' }

      before(:each) do
        allow(SessionTokenService).to receive(:encode).and_raise(JWT::EncodeError.new(msg_error))
      end

      it_behaves_like 'authentication failure response', 'encoding jwt error', :internal_server_error
    end
  end

  describe 'Validations' do
    describe 'Password' do
      context 'when there are errors with format' do
        let(:password) { 'avcDS!' }

        it_behaves_like 'authentication failure response', 'Password is invalid', :bad_request
      end

      context 'when is not present' do
        let(:password) { '' }

        it_behaves_like 'authentication failure response', "Password can't be blank", :bad_request
      end
    end

    describe 'Email' do
      context 'when there are errors with format' do
        let(:email) { 'testing@!' }

        it_behaves_like 'authentication failure response', 'Email is invalid', :bad_request
      end

      context 'when is not present' do
        let(:email) { '' }

        it_behaves_like 'authentication failure response', "Email can't be blank", :bad_request
      end
    end
  end

  describe 'Authentication' do
    context 'when email or password matching fails' do
      it_behaves_like 'authentication failure response', 'Incorrect email or password', :unauthorized
    end

    context 'when email or password matching fails' do
      let!(:user) { create(:user, email: email, password: password) }
      let(:token) { '$1$2$3' }

      before(:each) do
        allow(SessionTokenService).to receive(:encode).and_return(token)
      end

      it 'returns success object' do
        expect(subject.success?).to be_truthy
      end

      it 'returns ok status symbol' do
        expect(subject.status).to eq(:ok)
      end

      it 'returns user info in payload' do
        expect(subject.payload[:user]).to eq(user)
      end

      it 'returns token in payload' do
        expect(subject.payload[:token]).to eq(token)
      end
    end
  end
end
