RSpec.shared_examples 'registrations failure response' do |msg_error|
  it 'returns http status bad request' do
    post '/registrations', params: user_attributes
    expect(response).to have_http_status(:bad_request)
  end

  it 'returns error message for password presence' do
    post '/registrations', params: user_attributes
    expect(json_response[:errors]).to include(msg_error)
  end
end
