require 'rails_helper'

RSpec.describe DecryptedMessagesController, type: :controller do
  let!(:rsa) { create(:rsa) }
  let!(:dec_messages) { create_list(:decrypted_message, 5, rsa_id: rsa.id) }
  let(:rsa_id) { rsa.id }
  let(:id) { dec_messages.first.id }

  describe 'GET /rsas/:rsa_id/decrypted_messages' do
    before { get :index, params: { rsa_id: rsa_id } }

    context 'when rsa exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all rsa encrypted messages' do
        expect(JSON.parse(response.body).size).to eq 5
      end
    end

    context 'when rsa does not exist' do
      let(:rsa_id) { -1 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Rsa/)
      end
    end
  end

  describe 'GET /rsas/:rsa_id/decrypted_messages/:id' do
    before { get :show, params: { rsa_id: rsa_id, id: id } }

    context 'when rsa enecrypted message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the message' do
        expect(JSON.parse(response.body)['id']).to eq id
      end
    end

    context 'when rsa enecrypted message does not exist' do
      let(:id) { -1 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DecryptedMessage/)
      end
    end
  end

  describe 'POST /rsas/:rsa_id/decrypted_messages' do
    let(:valid_params) { { message: 'Big Smoke', rsa_id: rsa_id } }

    context 'when request is valid' do
      before { post :create, params: valid_params, format: :json }

      it 'creates an encrypted message' do
        json_response = JSON.parse response.body
        expect(json_response['message']).not_to eq(valid_params[:message])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end
  end
end
