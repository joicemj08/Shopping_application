class HomeController < ApplicationController
  layout 'home'

  def index
    @products = Product.all
     @offers = Offer.all
  end
  def show
    @products = Product.all
  end

end
