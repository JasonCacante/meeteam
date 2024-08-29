# spec/controllers/products_controller_spec.rb
require 'rails_helper'

RSpec.describe ProductsController, type: :request do
  describe 'GET #index' do
    let(:valid_params) { { page: 1, per_page: 10 } }
    let(:invalid_params) { { page: 0, per_page: 10 } }

    context 'with valid params' do
      it 'returns a successful response' do
        post '/products', params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'paginates products correctly' do
        post '/products', params: valid_params
        expect(JSON.parse(response.body)['table']['records'].size).to eq(10)
      end
    end

    context 'with invalid params' do
      it 'returns a bad request status if page is less than 1' do
        post '/products', params: invalid_params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Page starts at 1')
      end
    end
  end

  describe 'private methods' do
    describe '#pagiante_params' do
      it 'requires page and per_page parameters' do
        expect do
          post '/products', params: { key: 'name' }
        end.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
