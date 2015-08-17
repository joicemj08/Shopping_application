class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to home_index_path unless current_user.id == @user.id
  end

  def index
    #if current_user.manager?
     # @users = User.order("first_name").page(params[:page])
    #else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    #end
  end

  def create
    @user = User.new(params[:id])

  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end
end
