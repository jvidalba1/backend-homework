RSpec.shared_examples 'sessions failure response' do |msg_error|
  it "returns http code error bad request" do
    post "/sessions", params: { email: email, password: password }
    expect(response).to have_http_status(:bad_request)
  end

  it 'returns error message for password missing' do
    post "/sessions", params: { email: email, password: password }
    expect(json_response[:errors]).to include(msg_error)
  end
end

RSpec.shared_examples 'sessions failure not found response' do |email, password|
  it "returns http code error unauthorized" do
    post "/sessions", params: { email: email, password: password }
    expect(response).to have_http_status(:unauthorized)
  end

  it 'returns error message for password missing' do
    post "/sessions", params: { email: email, password: password }
    expect(json_response[:errors]).to include('Incorrect email or password')
  end
end
