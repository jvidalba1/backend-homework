require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  describe 'POST /create' do
    let(:user_attributes) { { user: attributes_for(:user) } }

    context 'when all params are correctly sent' do
      it 'returns http status created' do
        post '/registrations', params: user_attributes
        expect(response).to have_http_status(:created)
      end

      it 'returns the object created' do
        post '/registrations', params: user_attributes
        expect(json_response[:data][:user][:first_name]).to eq(user_attributes[:user][:first_name])
      end
    end

    context 'when email is not present' do
      before do
        user_attributes[:user][:email] = ''
      end

      it_behaves_like 'registrations failure response', "Email can't be blank"
    end

    context 'when email does not have a right format' do
      before do
        user_attributes[:user][:email] = 'testingOelo.com'
      end
      it_behaves_like 'registrations failure response', 'Email is invalid'
    end

    context 'when email is already taken' do
      before do
        old_user = create(:user)
        user_attributes[:user][:email] = old_user.email
      end

      it_behaves_like 'registrations failure response', 'Email has already been taken'
    end

    context 'when password is not sent' do
      before do
        user_attributes[:user][:password] = nil
      end

      it_behaves_like 'registrations failure response', "Password can't be blank"
    end

    context 'when password does not fit the format' do
      before do
        user_attributes[:user][:password] = "testing!"
      end

      it_behaves_like 'registrations failure response', 'Password is invalid'
    end
  end
end
