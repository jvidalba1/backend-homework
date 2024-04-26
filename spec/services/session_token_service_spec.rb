require 'rails_helper'

RSpec.describe SessionTokenService do
  let(:secret_key_base) { Rails.application.credentials.secret_key_base }

  describe 'Encode' do
    let(:user) { create(:user) }
    let(:payload) { { user_id: user.id, exp: 20.minutes.from_now } }

    it 'calls JWT class with encode method' do
      expect(JWT).to receive(:encode).with(payload, secret_key_base).and_return("$1$2$3")
      described_class.encode(payload)
    end
  end

  describe 'Decode' do
    let(:token) { '$1$2$3' }

    it 'calls JWT class with decode method' do
      expect(JWT).to receive(:decode).with(token, secret_key_base).and_return({})
      described_class.decode(token)
    end
  end
end
