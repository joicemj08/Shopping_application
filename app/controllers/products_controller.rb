#
# ProductsController -
#
# @author [Joice]
#
class ProductsController < ApplicationController
  # GET#show - /products/:id
  def show
    @product = Product.find(params[:id])
    @category = @product.category
  end

  def index
    # @products = Product.all
    @products = Product.order("name").page(params[:page])
    respond_to do |format|
      format.html #{ render html: @products }# index.html.erb
      format.json do
        html_string = render_to_string(
          'products/_products.html.erb', format: [:html], layout: false)
          render json: { html_string: html_string, products: @products }
      end
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end
  #@data = Category.where(:name => '@category.name' )

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

  private

  # Permitted params for product
  def product_params
    params.require(:product).permit(:name, :category_id, :unit_price, :quantity)
  end
end
