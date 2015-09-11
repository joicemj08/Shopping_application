#
# InitializeCart Module
#
# @author [Joice]
module InitializeCart
  extend ActiveSupport::Concern
  included do
    before_action :cart_init
  end

  def cart_init
    if session[:cart].present?
      @cart_products  =  Product.where(id: session[:cart].map { |obj| obj['product_id'] })
      @cart = session[:cart]
    end
  end
end
