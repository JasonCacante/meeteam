class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
    render json: @products
  end
end
