# generate mailer  
rails g mailer UserMialer  

# The content of the email lives in a view (more in a sec) which will be rendered.
# You can also set cc and bcc attributes. To send to multiple emails, use an array of email strings. 
#########################################################
# USERMAILERS 
#########################################################


class UserMialer < ActionMailer 
  # sender 
  default from: 'elarabyelaidy@gnail.com' 


  def welocme_email(user) 
    @user =  user 
    @url = 'http://example.com/login' 
    # reciver and the message 
    mail(to: user.email, subject: 'welcome user') 
    
    # Adding Attachments  
    attachments['filename.jpeg'] = File.read('/path/to/filename.jpeg') 
  end  

  def deliver_now 
  end 
end 

#############################################################
# USERCONTROLLER
############################################################# 
  

class UsersController < ApplicationController 

  def create 
    user = User.new(user_params) 
    msg = UserMialer.welocme_email(User) 
    msg.deliver_now 

    render :root 
  end 
end 


############################################### 
# VIEW FOR THE MAIL 
###############################################  

<!-- app/views/user_mailer/welcome_email.html.erb -->

<!DOCTYPE html>
<html>
  <head>
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  </head>
  <body>
    <h1>Welcome to example.com, <%= @user.name %></h1>
    <p>
      You have successfully signed up to example.com,
      your username is: <%= @user.login %>.<br />
    </p>
    <p>
      To login to the site, just follow this link: <%= @url %>.
    </p>
    <p>Thanks for joining and have a great day!</p>
  </body>
</html> 


###############################################################


# You  should have a text version of the mail to avoid flagged as a spam  
# notice the extension of the file .text.erb  

# When you call the mail method now, Action Mailer will detect the two templates 
# (text and HTML) and automatically generate a multipart/alternative email;
# the user's email client will be able to choose between the two formats.

# Sending out an email often takes up to 1sec. This is kind of slow. In particular, 
# if your Rails app is sending a mail as part of a controller action, 
# the user will have to wait an extra second for the HTTP response to be sent. 


###########################################################
# EMBED LINK IN EMAIL VIEWS
###########################################################


# app/config/environments/development.rb
config.action_mailer.default_url_options = { host: 'localhost:3000' }

# app/config/environments/production.rb
config.action_mailer.default_url_options = { host: 'www.production-domain.com' }  


#############################################
# LETTER OPENER
#############################################

# When running the development environment (your local machine), 
# instead of sending an email out to the real world, letter_opener will instead pop open the "sent" email in the browser.

Setup is two lines:

# Gemfile
gem 'letter_opener', group: :development

# config/environments/development.rb
config.action_mailer.delivery_method = :letter_opener

##########################################################
# EMAIL TEXT 
##########################################################
<%# app/views/user_mailer/welcome_email.text.erb %>

Welcome to example.com, <%= @user.name %>
===============================================

You have successfully signed up to example.com,
your username is: <%= @user.login %>.

To login to the site, just follow this link: <%= @url %>.

Thanks for joining and have a great day! 

