class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :categories)

    # Search products
    if params[:search].present?
      @products = @products.where(
        "LOWER(products.name) LIKE ?",
        "%#{params[:search].downcase}%"
      )
    end

    # Filter by brand
    if params[:brand_id].present?
      @products = @products.where(brand_id: params[:brand_id])
    end

    # Get all brands
    @brands = Brand.order(:name)

    # Sort products
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