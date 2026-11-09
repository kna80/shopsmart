class ProductsController < ApplicationController

  def index
    @products = Product.includes(:brand, :categories)

    if params[:search].present?
      @products = @products.where(
        "LOWER(products.name) LIKE ?",
        "%#{params[:search].downcase}%"
      )
    end

    @products = @products.order(:name)
  end

  def show
    @product = Product.includes(:brand, :categories, :tags)
                      .find(params[:id])
  end

end