class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[show edit update destroy]

  require 'securerandom'

  def index
    @products = current_user.products.all.order(created_at: :desc)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    random = SecureRandom.hex(2)
    @product.sku = "#{Time.current.to_i}#{random}"

    if @product.save
      respond_to :js
    else
      respond_to { |format| format.js { render js: "alert('input error')" } }
    end
  end

  def update
    if params[:status].present?
      @product.update(status: params[:status])
      redirect_to admin_products_path
    elsif @product.update(product_params)
      respond_to :js
    else
      respond_to { |format| format.js { render js: "alert('input error')" } }
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'delete success'
  end

  private

  def product_params
    params.require(:product).permit(:name, :status, :original_price, :price, pics: [])
  end

  def find_product
    @product = current_user.products.find_by(id: params[:id])
  end
end