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



