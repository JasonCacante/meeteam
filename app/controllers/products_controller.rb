class ProductsController < ApplicationController
  before_action :paginate_params, only: %i[index]

  def index
    @products = Product.paginate(
      page: params[:page],
      per_page: params[:per_page],
      key: params[:key],
      sort_by: params[:sort_by],
      sort_order: params[:sort_order]
    )
    render json: @products, status: :ok
  end

  private

  # Define strong parameters for products
  def paginate_params
    params.require(%i[page per_page])
    params.permit(%i[page per_page key sort_by sort_order])

    render json: { message: 'Page starts at 1' }, status: :bad_request if params[:page].to_i < 1
  end
end
