require 'rails_helper'

RSpec.describe RsasController, type: :controller do
  let!(:rsas)  { create_list(:rsa, 5) }
  let(:rsa_id) { rsas.first.id }

  describe "GET /new_keys" do
    before { get :new_keys }

    it "returns hash with three keys" do
      expect(JSON.parse response.body).to be_an Hash
    end

    it "returns hash including 'n', 'e' and 'd' keys" do
      expect(JSON.parse response.body).to include('n', 'e', 'd')
    end

    it "returns integer hash values" do
      expect(JSON.parse(response.body).values).to all be_an Integer
    end
  end

  describe "GET /rsas" do
    before { get :index }

    it "returns rsas" do
      json_response = JSON.parse response.body
      expect(json_response).not_to be_empty
      expect(json_response.size).to eq(5)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /rsas/:id" do
    context "when the record exists" do
      before { get :show, params: { id: rsa_id } }

      it "returns the rsa" do
        json_response = JSON.parse response.body
        expect(json_response).not_to be_empty
        expect(json_response['id']).to eq(rsa_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      before { get :show, params: { id: -1 } }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Rsa/)
      end
    end
  end

  describe "POST /rsas" do
    let(:valid_params) { Rsa.new_keys }

    context "when the request is valid" do
      before { post :create, params: valid_params, format: :json }

      it "creates a rsa" do
        expect(JSON.parse(response.body)['n']).to eq(valid_params[:n])
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post :create, params: { n: 123 }, format: :json }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end
end
