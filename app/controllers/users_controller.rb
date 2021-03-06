#
# UsersController -
#
# @author [Joice]
#
class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    redirect_to home_index_path unless current_user.id == @user.id || (current_user.manager? || current_user.admin?)
  end

  def index
    if current_user.manager? || current_user.admin?
      @users = User.order('first_name').page(params[:page])
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end
  # method to create new user by admin or manager
  def create_user
    if current_user.manager? || current_user.admin?
      @user = User.new(user_params)
      @user.password = 'test@123'
      @user.password_confirmation = 'test@123'
      redirect_to @user if @user.save
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end
  # method to edit user deatils
  def edit
    @user = User.find(params[:id])
  end

  def new
    if current_user.manager? || current_user.admin?
      @user = User.new
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end
  # method to delete a user
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  # method to update the details of a user
  def update
    @user = User.find(params[:id])
    redirect_to @user if @user.update(user_params)
  end
  # method to check whether an email already exists or not
  def check
    @user = User.find_by_email(params[:search])
    render json: @user.as_json
  end

  private

  # permitted params for user
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end
end
