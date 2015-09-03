#
# ProductsController -
#
# @author [Joice]
#
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :add_to_cart, :remove_from_cart]
  # GET#show - /products/:id
  def show
    @product = Product.find(params[:id])
    @category = @product.category
    @offers = @product.offers
  end

  def index
    if current_user.manager? || current_user.admin?
      @products = Product.search(params[:search]).page(params[:page])
      respond_to do |format|
        format.html #{ render html: @products }# index.html.erb
        format.json do
          html_string = render_to_string(
            'products/_products.html.erb', format: [:html], layout: false)
            render json: { html_string: html_string, products: @products }
        end
      end
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def search
    if(params[:category] == 'Categories')
      @products = Product.select("products.*, categories.name AS category_name").joins(:category).where(category_id: params[:id])
    else
      @products = Product.select("products.*, categories.name AS category_name").joins(:category).where(id: params[:id])
    end
    render :json => @products.as_json(methods: :avatar_url)
  end

  def add_to_cart
    session[:cart] = []  if session[:cart].nil?
    session[:cart] << {
      'product_id' => params[:id],\
      'quantity' => params[:quantity]
    }
    p session[:cart]
    @products  =  Product.where(id: session[:cart].map { |obj| obj['product_id'] })
    @quantities = session[:cart].map { |obj| obj['quantity'] if (obj['quantity'] != 'nil') }.compact
    render :partial => 'home/addcart'
  end

  def remove_from_cart
    p params[:index]
    position = session[:cart].find{|h| h['product_id'] == params[:index] }
    index = session[:cart].index(position)
    session[:cart].delete_at(index.to_i)
    @products  =  Product.where(id: session[:cart].map { |obj| obj['product_id'] })
    @quantities = session[:cart].map { |obj| obj['quantity'] if (obj['quantity'] != 'nil') }.compact
    p @quantities
    render :partial => 'home/addcart'

  end

  private

  # Permitted params for product
  def product_params
    params.require(:product).permit(:name, :category_id, :unit_price, :quantity, :avatar)
  end
end
