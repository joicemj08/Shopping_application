class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  respond_to :json
  def create

    user = User.new(user_params)
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors.full_messages, :status=>422
    end
  end

  protected

  def after_sign_up_path_for(resource)
    '/home'
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
