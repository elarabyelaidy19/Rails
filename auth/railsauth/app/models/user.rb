class User < ApplicationRecord 
  
  attr_reader :password 

  before_validation :ensure_session_token 
  validates :username, :session_token, presence: true  
  validates :password_digest, presence: { message: 'password can not be blank' }
  validates :password, length: { minimum: 6, allow_nil: true } 

  def password=(password) 
    @password = password 
  end 
end
