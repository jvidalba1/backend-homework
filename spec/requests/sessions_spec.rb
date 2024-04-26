require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "POST /create" do
    let(:password) { 'TestingOelo!' }
    let(:email) { 'testing_oelo@sample.com' }

    context 'when all params are set and user exist' do
      let!(:user) { create(:user, password: password, email: email) }
      let(:token) { '1$2$3$' }
      let(:auth_double) do
        double(
          'AuthenticationService',
          success?: true,
          payload: { user: { first_name: user.first_name }, token: token },
          status: :ok
        )
      end

      before(:each) do
        allow_any_instance_of(AuthenticationService).to receive(:call).and_return(auth_double)
      end

      it "returns http ok status" do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:ok)
      end

      it 'returns payload with user info including token' do
        post '/sessions', params: { email: email, password: password }
        expect(json_response[:data][:user][:first_name]).to eq(user.first_name)
        expect(json_response[:data][:token]).to eq(token)
      end
    end

    context 'when password is not sent' do
      let(:password) { '' }

      it_behaves_like 'sessions failure response', "Password can't be blank"
    end

    context 'when password does not have correct format' do
      let(:password) { 'TestingOelo' }

      it_behaves_like 'sessions failure response', 'Password is invalid'
    end

    context 'when email is not sent' do
      let(:email) { '' }

      it_behaves_like 'sessions failure response', "Email can't be blank"
    end

    context 'when email does not have correct format' do
      let(:email) { 'testing_oelo@.2com' }

      it_behaves_like 'sessions failure response', 'Email is invalid'
    end

    context 'when user is not found' do
      let!(:user) { create(:user, password: password, email: email) }

      it_behaves_like 'sessions failure not found response', 'different_email@sample.com', 'TestingOelo!'
    end

    context 'when authentications fails' do
      let!(:user) { create(:user, password: password, email: email) }

      it_behaves_like 'sessions failure not found response', 'testing_oelo@sample.com', 'DifferentPass!'
    end
  end

end
