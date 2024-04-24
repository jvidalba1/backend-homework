require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "POST /create" do
    let(:password) { 'TestingOelo!' }
    let(:email) { 'testing_oelo@sample.com' }

    context 'when all params are set and user exist' do
      let!(:user) { create(:user, password: password, email: email) }

      it "returns http ok status" do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:ok)
      end

      it 'returns payload with user info including token' do
        double_token = 'abc123'
        allow_any_instance_of(SessionTokenService).to receive(:encode).and_return(double_token)

        post '/sessions', params: { email: email, password: password }
        expect(json_response[:user][:first_name]).to eq(user.first_name)
        expect(json_response[:user][:token]).to eq(double_token)
      end
    end

    context 'when password is not sent' do
      let(:password) { '' }

      it 'returns http bad request' do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for password missing' do
        post "/sessions", params: { email: email, password: password }
        expect(json_response[:errors]).to include("Password can't be blank")
      end
    end

    context 'when password does not have correct format' do
      let(:password) { 'TestingOelo' }

      it 'returns http bad request' do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for wrong password format' do
        post "/sessions", params: { email: email, password: password }
        expect(json_response[:errors]).to include('Password is invalid')
      end
    end

    context 'when email is not sent' do
      let(:email) { '' }

      it 'returns http bad request' do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for email missing' do
        post "/sessions", params: { email: email, password: password }
        expect(json_response[:errors]).to include("Email can't be blank")
      end
    end

    context 'when email does not have correct format' do
      let(:email) { 'testing_oelo@.2com' }

      it 'returns http bad request' do
        post "/sessions", params: { email: email, password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for wrong email format' do
        post "/sessions", params: { email: email, password: password }
        expect(json_response[:errors]).to include('Email is invalid')
      end
    end

    context 'when user is not found' do
      let!(:user) { create(:user, password: password, email: email) }
      let(:different_email) { 'different_email@sample.com' }

      it 'returns http not found code' do
        post "/sessions", params: { email: different_email, password: password }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message for not found auth' do
        post "/sessions", params: { email: different_email, password: password }
        expect(json_response[:errors]).to include('Incorrect email or password.')
      end
    end

    context 'when authentications fails' do
      let!(:user) { create(:user, password: password, email: email) }
      let(:different_password) { 'DifferentPass!' }

      it 'returns http not found code' do
        post "/sessions", params: { email: email, password: different_password }
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message for incorrect authentication' do
        post "/sessions", params: { email: email, password: different_password }
        expect(json_response[:errors]).to include('Incorrect email or password.')
      end
    end
  end

end
