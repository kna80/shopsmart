class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.includes(:brand).order(:name)
  end
end