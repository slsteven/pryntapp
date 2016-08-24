class OauthUsersController < ApplicationController
  def new
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/tasks')
    if params[:code]
    # acknowledge code and get access token from FB
       session[:access_token] = session[:oauth].get_access_token(params[:code])
    end
    # auth established, now do a graph call:
    if session[:access_token]
      @api = Koala::Facebook::API.new(session[:access_token])
      begin
        @profile = @api.get_object("me?fields=email,name")
        name = @profile["name"].split(" ")
        @first_name = name[0]
        @last_name = name[1]
        @email = @profile["email"]
        user = User.find_by_email(@profile["email"])
        if user
          log_in user
          redirect_to "/tasks"
        end
      end
    end
  end
end
