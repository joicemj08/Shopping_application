class CategoriesController < ApplicationController
  def index
    @categories = Category.order("name").page(params[:page])
    #respond_to do |format|
     # format.html #{ render html: @products }# index.html.erb
      #format.json do
       # html_string = render_to_string(
        #  'categories/_categories.html.erb', format: [:html], layout: false)
         # render json: { html_string: html_string, categories: @categories }
      #end
    #end
  end

  def search
    @categories = Category.search(params[:search])
    render :json => @categories.as_json()
  end

  def show
    @category = Category.find(params[:id])
    @data = @category.id
    @products = Product.where(:category_id => @data)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:code, :name)
  end
end
