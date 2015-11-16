
#
# [class description]
#
# @author [qbuser]
#
class CartController < ApplicationController
#before_action :authenticate_user!, except: [:add_to_cart, :remove_from_cart]
  include InitializeCart
  # method to add items to cart
  def add_to_cart
    session[:cart] = []  if session[:cart].nil?
    if params[:id] != nil
      if session[:cart].any? { |h| h['product_id'] == params[:id] }
        item = session[:cart].find { |i| i['product_id'] == params[:id] }
        item['quantity'] = params[:quantity]
      else

          session[:cart] << {
            'product_id' => params[:id],\
            'quantity' => params[:quantity]
          }

      end
    end
    cart_init
    render partial: 'home/addcart'
  end

  # method to remove items from cart
  def remove_from_cart
    p params[:index]
    position = session[:cart].find { |h| h['product_id'] == params[:index] }
    index = session[:cart].index(position)
    session[:cart].delete_at(index.to_i)
    @cart_products  =  Product.where(id: session[:cart].map { |obj| obj['product_id'] })
    @cart_quantities = session[:cart].map { |obj| obj['quantity'] }
    render partial: 'home/addcart'

  end
  # method to purchase products
  def purchase
    if user_signed_in?
      session[:cart].each do |p|
        product = Product.find(p['product_id'].to_i)
        current_quantity = product.quantity
        qty = current_quantity.to_i - p['quantity'].to_i
        product.update(quantity: qty)
      end
      session[:cart] = nil
      render partial: 'home/checkout'
  else
    render template:'/devise/sessions/new', layout: false
  end
end
def view_cart
  render partial: 'home/addcart'
end
end
