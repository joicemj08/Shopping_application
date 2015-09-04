#
# Home Controller -
#
# @author [Joice]
#
class HomeController < ApplicationController
  layout 'home'
  before_action :authenticate_user!, except: :index
  # GET /home
  def index
    @user = User.new
    @offers = Offer.all
    @products = Product.search(params[:search])
    @categories = Category.search(params[:search])
    search_list =  @categories.map { |category| { label: category.name, category: 'Categories', id: category.id  } }
    search_list += @products.map { |product| { label: product.name, category: 'Products', id: product.id } }
    respond_to do |format|
      format.html
      format.json do
        html_string = render_to_string(
          'home/index.html.erb', format: [:html], layout: false)
        render json: { html_string: html_string, products: search_list }
      end
    end
  end
  #GET /home/:id
  def show
    @products = Product.all
  end
end
