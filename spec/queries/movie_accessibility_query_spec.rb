require 'rails_helper'

RSpec.describe MovieAccessibilityQuery do
  subject { described_class.new(filter, user).call }

  describe '#call' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    let(:public_movies) { create_list(:movie, 2, :for_all, user: another_user) }
    let!(:private_movie) { create(:movie, :for_self, user: another_user)}
    let!(:public_movie) { create(:movie, :for_all) }

    context 'when filter is public' do

      let(:filter) { 'public' }

      it 'returns all movies for public access' do
        expect(subject).to eq([public_movie] + public_movies)
      end
    end

    context 'when filter is private' do
      let(:filter) { 'private' }
      let(:user) { another_user }

      it 'returns all movies for private access' do
        expect(subject).to eq([private_movie] + public_movies)
      end
    end
  end
end
