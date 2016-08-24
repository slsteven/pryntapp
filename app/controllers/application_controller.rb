class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def profile_image
    if session[:access_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      @profile = @api.get_object("me?fields=email,name")
      if @profile["id"]
        return @profile["id"]
      end
    end
  end

  def current_user
    # session.clear
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  helper_method :current_user, :profile_image
end
