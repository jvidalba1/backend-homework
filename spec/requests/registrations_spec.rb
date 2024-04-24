require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  describe 'POST /create' do
    let(:user_attributes) { attributes_for(:user) }

    context 'when all params are correctly sent' do
      it 'returns http status created' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:created)
      end

      it 'returns the object created' do
        post '/registrations', params: user_attributes
        expect(json_response[:data]).to be_equal(user_attributes)
      end
    end

    context 'when email is not present' do
      before do
        user_attributes[:email] = ''
      end

      it 'returns http status bad request' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages for email presence' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:errors]).to include("Email can't be blank")
      end
    end

    context 'when email does not have a right format' do
      before do
        user_attributes[:email] = 'testingOelo.com'
      end

      it 'returns http status bad request' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for wrong format email' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:errors]).to include('Email is invalid')
      end
    end

    context 'when email is already taken' do
      before do
        old_user = create(:user)
        user_attributes[:email] = old_user.email
      end

      it 'returns http status bad request' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for wrong format email' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:errors]).to include('Email has already been taken')
      end
    end

    context 'when password is not sent' do
      before do
        user_attributes[:password] = nil
      end

      it 'returns http status bad request' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for password presence' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:errors]).to include("Password can't be blank")
      end
    end

    context 'when password does not fit the format' do
      before do
        user_attributes[:password] = "testing!"
      end

      it 'returns http status bad request' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message for password presence' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:errors]).to include('Password is invalid')
      end
    end
  end
end
