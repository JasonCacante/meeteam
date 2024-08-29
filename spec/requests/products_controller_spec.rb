# spec/controllers/products_controller_spec.rb
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let(:valid_params) { { page: 1, per_page: 10, key: 'name', sort_by: 'created_at', sort_order: 'asc' } }
    let(:invalid_params) { { page: 0, per_page: 10 } }

    before do
      create_list(:product, 30) # Assuming you have a factory for products
    end

    context 'with valid params' do
      it 'returns a successful response' do
        get :index, params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'paginates products correctly' do
        get :index, params: valid_params
        expect(JSON.parse(response.body).size).to eq(10)
      end
    end

    context 'with invalid params' do
      it 'returns a bad request status if page is less than 1' do
        get :index, params: invalid_params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Page starts at 1')
      end
    end
  end

  describe 'private methods' do
    controller(ProductsController) do
      def index
        render plain: 'index'
      end
    end

    describe '#pagiante_params' do
      it 'requires page and per_page parameters' do
        expect {
          get :index, params: { key: 'name' }
        }.to raise_error(ActionController::ParameterMissing)
      end

      it 'permits page, per_page, key, sort_by, and sort_order parameters' do
        params = ActionController::Parameters.new(page: 1, per_page: 10, key: 'name', sort_by: 'created_at', sort_order: 'asc')
        expect(controller.send(:pagiante_params)).to eq(params.permit(:page, :per_page, :key, :sort_by, :sort_order))
      end
    end
  end
end
