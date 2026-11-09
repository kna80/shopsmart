class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :categories).order(:name)
  end

  def show
    @product = Product.includes(:brand, :categories, :tags).find(params[:id])
  end
end