class SessionsController < ApplicationController 
  def create 
    username = params[:user_name] 
    password = params[:password] 

    user = User.where( 
     username: user_name,
     password: password 
    ).first  

    # # generate a 16-digit random token
    user.session_token = SecureRandom::urlsafe_base64(16) 
    user.save! 

    session[:session_token] = user.session_token 
    redirect_to feed_path 
  end 
end
