class ProductsController < ApplicationController
  def index
    @brands = Brand.order(:name)
    @categories = Category.order(:name)

    @products = Product.includes(:brand, :categories)

    # Search products by name
    if params[:search].present?
      search_term = params[:search].to_s.strip.downcase

      @products = @products.where(
        "LOWER(products.name) LIKE ?",
        "%#{Product.sanitize_sql_like(search_term)}%"
      )
    end

    # Filter products by brand
    if params[:brand_id].present?
      @products = @products.where(
        brand_id: params[:brand_id]
      )
    end

    # Filter products by category
    if params[:category_id].present?
      @products = @products.joins(:categories)
                           .where(categories: { id: params[:category_id] })
                           .distinct
    end

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

    # Pagination
    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.includes(:brand, :categories, :tags)
                      .find(params[:id])
  end
end
  end

  def show
    @product = Product.includes(:brand, :categories, :tags)
                      .find(params[:id])
                      
  end
end