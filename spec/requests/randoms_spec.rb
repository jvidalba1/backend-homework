require 'rails_helper'

RSpec.describe "Randoms", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/randoms/show"
      expect(response).to have_http_status(:success)
    end
  end

end
