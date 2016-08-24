module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    # session.clear
    puts "logout"
    session[:access_token] = nil
    session[:user_id] = nil
  end
end
