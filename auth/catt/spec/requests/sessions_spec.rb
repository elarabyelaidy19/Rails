require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /Users" do
    it "returns http success" do
      get "/sessions/Users"
      expect(response).to have_http_status(:success)
    end
  end

end
