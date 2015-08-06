class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.\
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  class User::ParameterSanitizer < Devise::ParameterSanitizer
    def sign_in
      default_params.permit(:username, :email)
    end
  end
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    end

    def devise_parameter_sanitizer
      if resource_class == User
        User::ParameterSanitizer.new(User, :user, params)
      else
        super # Use thec default one
      end
    end
  protect_from_forgery with: :exception
end

