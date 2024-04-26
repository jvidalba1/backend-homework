require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  describe 'abilities' do
    subject { Ability.new(user) }
    let(:user) { create(:user) }

    context 'when is the owner of the movie' do
      let(:movie) { create(:movie, user: user) }

      it 'is be able to update' do
        expect(subject).to be_able_to(:update, movie)
      end
    end

    context 'when is not the owner of the movie' do
      let(:user2) { create(:user) }
      let!(:movie) { create(:movie, user: user2) }

      it 'is not be able to update' do
        expect(subject).to_not be_able_to(:update, movie)
      end
    end
  end
end
