# craeting a new form to fill in user credintials   

class User < ApplicationRecord 

  # verifies the username/password 
  def self.find_by_credentials(username, password) 
    user = User.find_by(username: username) 
    return nil if user.nil? 
    user.is_password?(password) ? user : nil 
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
      render json: "welcome #{user.username}"  
    end 
  end 
end 

############### 
# User controller  
 
class User < ApplicationController 
 

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