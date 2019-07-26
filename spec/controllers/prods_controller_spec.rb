require 'rails_helper'

RSpec.describe ProdsController, type: :controller do
  describe "prods#destroy action" do
    it "shouldn't allow users who didn't create the prod destroy" do
      prod = FactoryBot.create(:prod)
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: prod.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy a prod" do
      prod = FactoryBot.create(:prod)
      delete :destroy, params: { id: prod.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy prods" do
      prod = FactoryBot.create(:prod)
      sign_in prod.user
      delete :destroy, params: { id: prod.id }
      expect(response).to redirect_to root_path
      prod = Prod.find_by_id(prod.id)
      expect(prod).to eq nil   
    end

    it "should return a 404 message if we cannot find a prod with the id that is specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "prods#update action" do
    it "shouldn't let users who didn't create the prod update it" do
      prod = FactoryBot.create(:prod)
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: prod.id, prod: { name: 'airpod', description: 'airpod', cost: 'airpod' } }
    end
      
    it "shouldn't let unauthenticated users update a prod" do
      prod = FactoryBot.create(:prod)
      patch :update, params: { id: prod.id, prod: { name: "Hello", description: "Hello", cost: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update prods" do
      prod = FactoryBot.create(:prod, name: "Initial Value", description: "Initial Value", cost: "Initial Value")
      sign_in prod.user

      patch :update, params: { id: prod.id, prod: { name: 'Changed', description: 'Changed', cost: 'Changed' } }
      expect(response).to redirect_to root_path
      prod.reload
      expect(prod.name).to eq "Changed"
      expect(prod.description).to eq "Changed"
      expect(prod.cost).to eq 0.0
    end

    it "should have http 404 error if the prod cannot be found" do
      user = FactoryBot.create(:user)
      sign_in user

      patch :update, params: { id: "YOLOSWAG", prod: { name: 'Changed', description: 'Changed', cost: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an https status of unprocessable_entity" do
      prod = FactoryBot.create(:prod, name: "Initial Value", description: "Initial Value", cost: "Initial Value")
      sign_in prod.user

      patch :update, params: { id: prod.id, prod: { name: '', description: '', cost: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      prod.reload
      expect(prod.name).to eq "Initial Value"
      expect(prod.description).to eq "Initial Value"
      expect(prod.cost).to eq 0.0
    end
  end

  describe "prods#edit action" do
    it "shouldn't let a user who did not create the prod edit a prod" do
      prod = FactoryBot.create(:prod)
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: prod.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit a prod" do
      prod = FactoryBot.create(:prod)
      get :edit, params: { id: prod.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the prod is found" do
      prod = FactoryBot.create(:prod)
      sign_in prod.user

      get :edit, params: { id: prod.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the prod is not found" do
      user = FactoryBot.create(:user)
      sign_in user

      get :edit, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "prods#show action" do
    it "should successfully show the page if the prod is found" do
      prod = FactoryBot.create(:prod)
      get :show, params: { id: prod.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the prod is not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

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
      user = FactoryBot.create(:user)
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
      user = FactoryBot.create(:user)
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
      user = FactoryBot.create(:user)
      sign_in user

      prod_count = Prod.count
      post :create, params: { prod: { name: '', description: '', cost: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(prod_count).to eq Prod.count
    end

  end
end
