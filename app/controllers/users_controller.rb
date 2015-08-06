class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user.id == @user.id
  end

  def index
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
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
