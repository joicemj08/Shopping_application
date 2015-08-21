class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  protected

  def after_sign_up_path_for(resource)
    '/home'
  end
end
