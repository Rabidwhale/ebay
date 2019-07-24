require 'rails_helper'

RSpec.describe ProdsController, type: :controller do
  describe "prods#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "prods#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "prods#create action" do
    it "should successfully create a new prod in our database" do
      post :create, params: { prod: { name: 'airpods', description: 'airpods', cost: '100' } }
      expect(response).to redirect_to root_path

      prod = Prod.last
      expect(prod.name).to eq("airpods")
      expect(prod.description).to eq("airpods")
      expect(prod.cost).to eq(0.1e3)
    end
  end  
end
