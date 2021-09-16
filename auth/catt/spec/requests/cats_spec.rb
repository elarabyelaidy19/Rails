require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/cats/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "render the cats index" do
      get :index
      expect(response).to be_success 
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/cats/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/cats/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/cats/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
