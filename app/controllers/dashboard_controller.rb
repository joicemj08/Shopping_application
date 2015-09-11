#
# Dashboard Controller -
#
# @author [Joice]
#
class DashboardController < ApplicationController
  before_action :authenticate_user!
  # GET  /dashboard
  def index
    if current_user.manager? || current_user.admin?
      @product = Product.count
      p @product
      @categories = Category.count
      @users = User.count
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end
end
