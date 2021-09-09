class SessionsController < ApplicationController 
  
  # login create session 
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

  # log out destroy session set it to nil 
  def destroy 
    session_token = session[:session_token] 
    user = User.find_by(session_token: session_token) 
    
    user.session_token = SecureRandom.urlsafe_base64(16) 
    user.save!
    session[:session_token] = nil 

    # flash for the current request only seprated from next state and render the same page again
    # using with rendering within the same request values stored for current request only
    if user.nil? 
      flash.now[:notices] =|| [] 
      flash.now[:notices] << "faild login"  

      render :new
      return 
    end 
    
    # creating flash for the current and next request 
    # redirct and render using with
    flash[:notices] =|| [] 
    flash[:notices] << "You logged out! see you soon" 

    redirect_to root_path 
  end 
end
