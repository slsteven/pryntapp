class UsersController < ApplicationController
  def new
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email")
    puts session.to_s + "<<< session"

    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      if session[:access_token]
        redirect_to "/oauth"
      end
    end

    respond_to do |format|
       format.html {  }
    end
  end

  def index
    users = User.all
    respond_to do |format|
      format.html {  }
      format.json { render json: users}
    end
  end

  def show
    if session[:access_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      @profile = @api.get_object("me?fields=email,name")
      puts "SHOWW", @profile
    end

    @user = User.find(params[:id])
    @tasks = @user.tasks
    response = { :user => @user, :user_tasks => @tasks }
    respond_to do |format|
      format.html {  }
      format.json { render json: response}
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created"
      last_created_user = User.last
      log_in @user
      redirect_to "/tasks"
      # redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/home'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
