# craeting a new form to fill in user credintials   

class User < ApplicationRecord 

  validates :session_token, presence: true 
  after_initialize :ensure_session_token 
  
  # genrte session token 
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16) 
  end 

  # reset session token  
  def self.reset_session_token 
    self.session_token = self.class.generate_session_token 
    self.save! 
    self.session_token
  end 

  # verifies the username/password 
  def self.find_by_credentials(username, password) 
    user = User.find_by(username: username) 
    return nil if user.nil? 
    user.is_password?(password) ? user : nil 
  end  

  private 
  # ensuring every log in has a session token 
  def ensure_session_token  
    self.session_token =|| self.class.generate_session_token 
  end 
end  


# Mgration 
class AddSessionTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :session_token, :string, null: false
    add_index :users, :session_token, unique: true
  end
end
#############################################
#CONTROLLER
############################################# 

class SessionController < ApplicationController 

  def create 
    user = User.find_by_credentials( 
      params[:user][:username], 
      params[:user][:password]
    ) 

    if user.nil? 
      render json: 'credintials are wrong' 
    else  
      login!(user) 
      redirect_to user_path(user)   
    end 
  end  

  def destroy 
    logout! 
    redirect_to new_session_url  
  end 
end 

##################################
# User controller  
################################## 
class User < ApplicationController 
  # callback for redirect unsigned user to logging before any action 
  before_action :require_current_user!, except: [:create, :new]

  def creat 
    user =  User.new(params[:user]) 

    if @user.save 
      login!(@user) 
      redirect_to user_url(@user) 
    else 
      render json: @user.errors.full_messages 
    end 
  end

  
end 

############################################
# Application controller commons for all   
############################################
class ApplicationController < ApplicationController::Base 
  
  # This will make current_user available in all views.
  helpe_method :current_user

  # create session token and assign it to the current user HELPER METHOD
  def login!(user) 
    @current_user = user 
    session[:session_token] = user.session_token 
  end  

  # create log out session and reset the session 
  def logout! 
    # invalidate the old session token
    current_user.try(:reset_session_token) 
    session[:session_token] = nil 
  end 

  # create a helper method to using it throught in view  
  def current_user 
    return nil if session[:session_token].nil?  
    @current_user ||= User.find_by(session_token: session[:session_token]) 
  end  

  # redirect_to a creat/new form while user not logged in 
  def require_current_user! 
    redirect_to new_session_url if current_user.nil?
  end 
#######################################
# VIEWS 
#######################################


# new page
<!-- app/views/sessions/new.html.erb -->

<h1>Log in!</h1>

<form action="/session" method="POST">
  <input
    type="hidden"
    name="authenticity_token"
    value="<%= form_authenticity_token %>">

  <label for="user_username">Username</label>
  <input type="text" name="user[username]" id="user_username">

  <br />

  <label for="user_password">Password</label>
  <input type="password" name="user[password]" id="user_password"> 
  
  <br />

  <input type="submit" value="Log in!">
</form> 


################## 
# show page 

<!-- app/views/users/show.html.erb -->
<h1><%= @user.username %></h1>

<p>Hello, dear user!</p> 

############ 
# LOG OUT PAGE 
<!-- app/views/layouts/application.html.erb -->

<!-- ... -->
<% if !current_user.nil? %>
  <ul>
    <li>Logged in as: <%= current_user.username %></li>
    <li>
      <form action="<%= session_url %>" method="POST">
        <input type="hidden"
               name="authenticity_token"
               value="<%= form_authenticity_token %>">
        <input type="hidden" value="delete" name="_method" />
        <input type="submit" value="Logout" />
      </form>
    </li>
  </ul>
<% end %>

<%= yield %>

</body>
</html>