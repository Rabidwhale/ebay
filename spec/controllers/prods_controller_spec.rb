require 'rails_helper'

RSpec.describe ProdsController, type: :controller do
  describe "prods#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "prods#new action" do
    it "should require users to be logged in" do 
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "prods#create action" do

    it "should require users to be logged in" do
      post :create, params: { prod: { name: 'airpods', description: 'airpods', cost: '100' } }
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should successfully create a new prod in our database" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      post :create, params: { prod: { name: 'airpods', description: 'airpods', cost: '100' } }
      expect(response).to redirect_to root_path

      prod = Prod.last
      expect(prod.name).to eq("airpods")
      expect(prod.description).to eq("airpods")
      expect(prod.cost).to eq(0.1e3)
      expect(prod.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = User.create(
        email:                 'fakeuser@gmail.com',
        password:              'secretPassword',
        password_confirmation: 'secretPassword'
      )
      sign_in user

      prod_count = Prod.count
      post :create, params: { prod: { name: '', description: '', cost: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(prod_count).to eq Prod.count
    end

  end
end
