require 'rails_helper'

RSpec.describe Resources::MoviesController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    let(:filter_params) { }
    let(:another_user) { create(:user) }
    let!(:public_movies) { create_list(:movie, 2, :for_all, user: another_user) }
    let!(:private_movie) { create(:movie, :for_self, user: user) }
    let!(:public_movie) { create(:movie, :for_all, user: user) }

    before(:each) do
      allow(SessionTokenService).to receive(:decode).and_return({ user_id: user.id })
    end

    context 'when there is no filter' do
      it "returns http ok" do
        get '/movies', params: filter_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the exactly count for movies for public access' do
        get '/movies', params: filter_params
        expect(json_response[:data][:movies].count).to eq(3)
      end
    end

    context 'when there is a filter for public elements' do
      let(:filter_params) { { accessibility: 'public' } }

      it "returns http ok" do
        get '/movies', params: filter_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the exactly count for movies for public access' do
        get '/movies', params: filter_params
        expect(json_response[:data][:movies].count).to eq(3)
      end
    end

    context 'when there is a filter for private elements' do
      let(:filter_params) { { accessibility: 'private' } }

      it "returns http ok" do
        get '/movies', params: filter_params
        expect(response).to have_http_status(:ok)
      end

      it 'returns the exactly count for movies for public access' do
        get '/movies', params: filter_params
        expect(json_response[:data][:movies].count).to eq(2)
      end
    end
  end

  describe 'POST /create' do
    let(:movie_params) { }

    before(:each) do
      allow(SessionTokenService).to receive(:decode).and_return({ user_id: user.id })
    end

    context 'when movie is correctly saved' do
      let(:movie_params) { attributes_for(:movie) }

      it 'returns http status created' do
        post '/movies', params: { movie: movie_params }
        expect(response).to have_http_status(:created)
      end

      it 'returns the movie data' do
        post '/movies', params: { movie: movie_params }
        expect(json_response[:data][:movie][:name]).to eq(movie_params[:name])
      end
    end

    context 'when params are not set correctly' do
      let(:movie_params) { attributes_for(:movie) }

      context 'when title name movie is not sent' do
        before do
          movie_params[:name] = ''
        end

        it 'returns bad request http code' do
          post '/movies', params: { movie: movie_params }
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns errors for model' do
          post '/movies', params: { movie: movie_params }
          expect(json_response[:errors]).to include("Name can't be blank")
        end
      end
    end
  end

  describe 'PUT /movies/:id' do
    before(:each) do
      allow(SessionTokenService).to receive(:decode).and_return({ user_id: user.id })
    end

    context 'when is trying to update a not own movie' do
      let(:another_user) { create(:user) }
      let!(:movie) { create(:movie, user: another_user ) }

      it 'return access denied' do
        put "/movies/#{movie.id}"
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns message for access denied' do
        put "/movies/#{movie.id}"
        expect(json_response[:errors]).to include('You are not authorized for this action.')
      end
    end

    context 'when record is not found' do
      it 'return not found http error' do
        put "/movies/969"
        expect(response).to have_http_status(:not_found)
      end

      it 'returns message for not found record' do
        put "/movies/969"
        expect(json_response[:errors]).to include('Record not found')
      end
    end

    context 'when movie is correctly updated' do
      let!(:movie) { create(:movie, user: user ) }
      let(:movie_params) { { name: 'New title name' } }

      it 'returns http status ok' do
        put "/movies/#{movie.id}", params: { movie: movie_params }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the movie data updated' do
        put "/movies/#{movie.id}", params: { movie: movie_params }
        expect(json_response[:data][:movie][:name]).to eq(movie_params[:name])
      end
    end

    context 'when params are not set correctly' do
      let!(:movie) { create(:movie, user: user ) }
      let(:movie_params) { attributes_for(:movie) }

      context 'when title name movie is not sent' do
        before do
          movie_params[:name] = ''
        end

        it 'returns bad request http code' do
          put "/movies/#{movie.id}", params: { movie: movie_params }
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns errors for model' do
          put "/movies/#{movie.id}", params: { movie: movie_params }
          expect(json_response[:errors]).to include("Name can't be blank")
        end
      end
    end
  end
end
