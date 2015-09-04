#
# RegistrationsController -
#
# @author [Joice]
#
class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  respond_to :json, :html
  def create
    user = User.new(user_params)
    if user.save
      render json: { success: true, error: {} }
    else
      render json: { success: false, error: user.errors.full_messages }
    end
  end

  protected

  def after_sign_up_path_for(resource)
    '/home'
  end

  def after_inactive_sign_up_path_for(resource)
    '/home' # Or :prefix_to_your_route
  end

  private

  # permitted params for user
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
