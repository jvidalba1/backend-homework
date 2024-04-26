RSpec.shared_examples 'authentication failure response' do |msg_error, status|
  it 'returns failure object' do
    expect(subject.success?).to be_falsy
  end

  it 'returns bad request symbol' do
    expect(subject.status).to eq(status)
  end

  it 'returns error message' do
    expect(subject.errors).to include(msg_error)
  end
end
