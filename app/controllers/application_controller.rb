class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.\
  before_filter :store_location
  protect_from_forgery with: :exception
  #after_filter :store_location

  def store_location
    # store last url - needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if request.path != '/users/sign_in' &&
        request.path != '/users/sign_out' &&
        !request.xhr? # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    #set page to display after sign in
    dashboard_index_path
  end

  def after_sign_up_path_for(resource)
    #set page to display after sign up
    '/home'
  end
end
