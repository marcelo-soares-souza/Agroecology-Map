# frozen_string_literal: true

# FILEPATH: /home/marcelo/Development/Pessoal/agroecologymap/spec/controllers/locais_controller_spec.rb
require "rails_helper"

RSpec.describe LocaisController, type: :controller do
  let(:usuario) { create(:usuario) }
  let(:local) { create(:local, usuario:) }
  let(:valid_attributes) { attributes_for(:local, usuario:) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: local.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    before do
      sign_in usuario
    end

    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    before do
      sign_in usuario
    end


    it "returns a success response" do
      get :edit, params: { id: local.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before do
      sign_in usuario
    end

    context "with valid params" do
      it "creates a new Local" do
        expect {
          post :create, params: { local: attributes_for(:local) }
        }.to change(Local, :count).by(1)
      end

      it "redirects to the created local" do
        post :create, params: { local: attributes_for(:local) }
        expect(response).to redirect_to(Local.last)
      end
    end

    context "with invalid params" do
      it "does not create a new Local" do
        expect {
          post :create, params: { local: attributes_for(:local, nome: nil) }
        }.to change(Local, :count).by(0)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { local: attributes_for(:local, nome: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    before do
      sign_in usuario
    end

    context "with valid params" do
      let(:new_attributes) {
        { nome: "New Name" }
      }

      it "updates the requested local" do
        put :update, params: { id: local.to_param, local: new_attributes }
        local.reload
        expect(local.nome).to eq("New Name")
      end

      it "redirects to the local" do
        put :update, params: { id: local.to_param, local: new_attributes }
        local.reload
        expect(response).to redirect_to(local)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: local.to_param, local: attributes_for(:local, nome: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in usuario
    end

    it "destroys the requested local" do
      local = Local.create! valid_attributes
      expect {
        delete :destroy, params: { id: local.to_param }
      }.to change(Local, :count).by(-1)
    end

    it "redirects to the locais list" do
      local = Local.create! valid_attributes
      delete :destroy, params: { id: local.to_param }
      expect(response).to redirect_to(locais_url)
    end
  end
end
