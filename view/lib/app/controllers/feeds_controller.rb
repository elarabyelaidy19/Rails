class FeedsController < ApplicationController 

  def show 
    session_token = session[:session_token] 
    @user = User.find_by(session_token: session_token) 
  end 
end


