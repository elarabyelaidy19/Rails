# BCrypt 

require 'bcrypt' 

pass = BCrypt::Paswword.create('my_password')  
# => "$2a$10$sl.3R32Paf64TqYRU3DBduNJkZMNBsbjyr8WIOdUi/s9TM4VmHNHO" 
pass.is_password?('my_password')  
# is_password hashs string and comparing it with hash return true if equal 
# => true
pass.is_password?('password')
# => false 

################################
# MODEL
###############################

# Digest is another name of the hash 
# creat user table with user_name, password columns 

u = User.new # creat objet of the user model 
u.user_name = 'elaraby' 

u.password_digest = BCrypt::Paswword.create('my_password') 
# => "$2a$10$sl.3R32Paf64TqYRU3DBduNJkZMNBsbjyr8WIOdUi/s9TM4VmHNHO"  
u.save 
# => true 

# Verify  password 
u = User.first
# new method builds password from a hashing string 
BCrypt::Paswword.new(u.password_digest).is_password?('my_password')
# => true  


############################################# 
# Write User#password= And User#is_password? 
#############################################

# set the password_digest column in the database 
# database does'nt save the password itself 
class User < ApplicationRecord 

  #def password=(password) 
   # self.password_digest = BCrypt::Paswword.creat(password) 
  #end   
  ## == 
  attr_reader :password 

  validates :username, presence: true  
  validates :password_digest, presence: { message: 'password can\'t be empty' }
  validates :password, presence: length: { minimum: 6, allow_nil: true }
  # Verifying the password 
  def is_password?(password) 
    BCrypt::Paswword.new(self.password_digest).is_password?(password) 
  end 
end 



##############################################
# Creating new Users 
############################################## 

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end 

###############################################
# add View and Partial 
############################################### 

# <!-- app/views/users/new.html.erb -->

<h1>Create User</h1>

<%= render "form", user: @user %>

# app/views/users/_form.html.erb   

<% action = (user.persisted? ? user_url(user) : users_url) %>
<% method = (user.persisted? ? "patch" : "post") %>
<% message = (user.persisted? ? "Update user" : "Create user") %>

<form action="<%= action %>" method="post">
  <input
     name="_method"
     type="hidden"
     value="<%= method %>">
  <input
     name="authenticity_token"
     type="hidden"
     value="<%= form_authenticity_token %>">

  <label for="user_username">Username</label>
  <input
     id="user_username"
     name="user[username]"
     type="text">
  <br>

  <label for="user_password">Password</label>
  <input
     id="user_password"
     name="user[password]"
     type="password">
  <br>

  <input type="submit" value="<%= message %>">
</form> 





