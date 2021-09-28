require 'socket' 

server = TCPServer.new(3000) 

while true 
  socket = server.accept 

  socket.puts("THANKS FOR CONNECTION") 
  socket.puts("Enter Your Name") 
  name = socket.gets.chomp
  socket.puts("Goodbye #{name}")
  socket.close
end 