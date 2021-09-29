require 'socket' 
require 'thread'
require 'json'
Thread.abort_on_exception = true 

$id = 2
$cats = [
  {id: 0, name: "mar"}, 
  {id: 1, name: "bal"}  
] 

server = TCPServer.new(3000) 
 

def handle_request(socket) 
  Thread.new do 
    line1 = socket.gets.chomp 
    re = /^([^ ]+) ([^ ]+) HTTP\/1.1$/ 
    match_date = re.match(line1) 
    verb = match_date[1] 
    path = match_date[2] 
    cat_reg = /\/cats\/(\d+)/

    if [verb, path] == ["GET", "/cats"] 
      socket.puts $cats.to_json 

    elsif verb == "GET" && cat_reg =~ path 
      match_date2 =  cat_reg.match(path) 
      cate_id = Integer(match_date2[1]) 
      cat = $cats.find { |cat| cat[:id] == cate_id} 
      socket.puts cat.to_json
      
    elsif verb == "DELETE" && cat_reg =~ path 
      match_date2 =  cat_reg.match(path) 
      cate_id = Integer(match_date2[1]) 
      $cats.reject! {|cat| cat[:id] == cate_id }  

      socket.puts true.to_json
    end 
    socket.close
  end 
  puts "spawned worker thread"
end 


=begin     
  socket.puts("THANKS FOR CONNECTION") 
  socket.puts("Enter Your Name") 
  name = socket.gets.chomp
  socket.puts("Goodbye #{name}")
  socket.close 
  end 
  puts "spawned worker thread"
=end


while true 
  socket = server.accept 
  handle_request(socket)
end 