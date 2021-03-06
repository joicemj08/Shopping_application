#
# ProductsController -
#
# @author [Joice]
#
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :add_to_cart, :remove_from_cart, :purchase]
  include InitializeCart
  # GET#show - /products/:id
  def show
    @product = Product.find(params[:id])
    @category = @product.category
    @offers = @product.offers
  end

  def index
    if current_user.manager? || current_user.admin?
      @products = Product.search(params[:search]).page(params[:page])
      @pdts = Product.all
      respond_to do |format|
        format.csv { send_data @pdts.to_csv }
        format.xls {}#{ send_data @pdts.to_csv(col_sep: "\t") } }
        format.html # { render html: @products }# index.html.erb
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

  def import
    Product.import(params[:file])
    file = params[:file]
    #Creek::Book.new file.path, check_file_extension: false
    redirect_to products_path
  end

  def import_creek
    Product.import_creek(params[:file])
    redirect_to products_path
  end

  def import_file
    file_data = params[:datafile]
    File.open(params[:datafile].path) do |file|
      file.each_line do |line|
        p line
       ## does stuff here....
      end
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
    redirect_to products_path, notice: "Products imported."
  end
  # method to search using autocomplete feature
  def search
    if (params[:category] == 'Categories')
      @products = Product.select('products.*, categories.name AS category_name').joins(:category).where(category_id: params[:id])
    else
      @products = Product.select('products.*, categories.name AS category_name').joins(:category).where(id: params[:id])
    end
    render json: @products.as_json(methods: :avatar_url)
  end

  private

  # Permitted params for product
  def product_params
    params.require(:product).permit(:name, :category_id, :unit_price, :quantity, :avatar)
  end
end
