# frozen_string_literal: true

# FILEPATH: /home/marcelo/Development/Pessoal/agroecologymap/spec/controllers/experiencia_agroecologicas_controller_spec.rb
require "rails_helper"

RSpec.describe ExperienciaAgroecologicasController, type: :controller do
  let(:usuario) { create(:usuario) }
  let(:local) { create(:local, usuario:) }
  let(:tema_experiencia_agroecologica) { create(:tema_experiencia_agroecologica, usuario:) }
  let(:experiencia_agroecologica) { create(:experiencia_agroecologica, usuario:, local:, tema_experiencia_agroecologica:) }
  let(:valid_attributes) { attributes_for(:experiencia_agroecologica, usuario:, local:, tema_experiencia_agroecologica:) }

  before do
    sign_in usuario
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: experiencia_agroecologica.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { local_id: local.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: experiencia_agroecologica.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ExperienciaAgroecologica" do
        expect {
          post :create, params: { experiencia_agroecologica: attributes_for(:experiencia_agroecologica, usuario_id: usuario.id, local_id: local.id, tema_experiencia_agroecologica_id: tema_experiencia_agroecologica.id) }
          # post :create, params: { experiencia_agroecologica: attributes_for(:experiencia_agroecologica) }
        }.to change(ExperienciaAgroecologica, :count).by(1)
      end

      it "redirects to the created experiencia_agroecologica" do
        post :create, params: { experiencia_agroecologica: attributes_for(:experiencia_agroecologica, usuario_id: usuario.id, local_id: local.id, tema_experiencia_agroecologica_id: tema_experiencia_agroecologica.id) }
        expect(response).to redirect_to(ExperienciaAgroecologica.last)
      end
    end

    context "with invalid params" do
      it "does not create a new ExperienciaAgroecologica" do
        expect {
          post :create, params: { experiencia_agroecologica: attributes_for(:experiencia_agroecologica, nome: nil) }
        }.to change(ExperienciaAgroecologica, :count).by(0)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { experiencia_agroecologica: attributes_for(:experiencia_agroecologica, nome: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { nome: "New Name" }
      }

      it "updates the requested experiencia_agroecologica" do
        put :update, params: { id: experiencia_agroecologica.to_param, experiencia_agroecologica: new_attributes }
        experiencia_agroecologica.reload
        expect(experiencia_agroecologica.nome).to eq("New Name")
      end

      it "redirects to the experiencia_agroecologica" do
        put :update, params: { id: experiencia_agroecologica.to_param, experiencia_agroecologica: new_attributes }
        experiencia_agroecologica.reload
        expect(response).to redirect_to(experiencia_agroecologica)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: experiencia_agroecologica.to_param, experiencia_agroecologica: attributes_for(:experiencia_agroecologica, nome: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested experiencia_agroecologica" do
      experiencia_agroecologica = ExperienciaAgroecologica.create! valid_attributes
      expect {
        delete :destroy, params: { id: experiencia_agroecologica.to_param }
      }.to change(ExperienciaAgroecologica, :count).by(-1)
    end

    it "redirects to the experiencia_agroecologicas list" do
      experiencia_agroecologica = ExperienciaAgroecologica.create! valid_attributes
      delete :destroy, params: { id: experiencia_agroecologica.to_param }
      expect(response).to redirect_to(experiencia_agroecologicas_url)
    end
  end
end
