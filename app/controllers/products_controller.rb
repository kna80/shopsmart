class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :categories)

    if params[:search].present?
      @products = @products.where(
        "LOWER(products.name) LIKE ?",
        "%#{params[:search].downcase}%"
      )
    end

    case params[:sort]
    when "price_low"
      @products = @products.order(price: :asc)
    when "price_high"
      @products = @products.order(price: :desc)
    when "name_desc"
      @products = @products.order(name: :desc)
    else
      @products = @products.order(name: :asc)
    end
  end

  def show
    @product = Product.includes(:brand, :categories, :tags)
                      .find(params[:id])
  end
end