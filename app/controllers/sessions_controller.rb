class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to "/tasks"
    else
      flash[:notice] = ["Invalid combination"]
      redirect_to home_path
    end
  end

  def destroy
    log_out
    redirect_to '/home'
  end

end
