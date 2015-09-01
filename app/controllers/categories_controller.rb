#
# CategoriesController -
#
# @author [Joice]
#
class CategoriesController < ApplicationController
   before_action :authenticate_user!
   # GET  /categories
  def index
    @categories = Category.order("name").page(params[:page])
  end
  #GET  /search
  def search
    @categories = Category.search(params[:search])
    render :json => @categories.as_json
  end
  #GET  /categories/:id
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
  # GET  /categories/new
  def new
    @category = Category.new
  end
  # GET  /categories/:id/edit
  def edit
    @category = Category.find(params[:id])
  end
  #POST  /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end
  #PATCH  /categories/:id
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end
  #DELETE /categories/:id
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  # Permitted params for product
  def category_params
    params.require(:category).permit(:code, :name, sub_categories_attributes: [:id, :code, :name, :category_id, :_destroy])
  end
end
