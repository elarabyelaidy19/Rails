require 'socket' 
require 'thread'
require 'json'
Thread.abort_on_exception = true 

$id = 0 
$cats = [] 

server = TCPServer.new(3000) 


def handle_request(socket) 
  Thread.new do 
    cmd = socket.gets.chomp 
    case cmd  
    when "INDEX" # READ
      socket.puts $cats.to_json
    
    when "SHOW"   # READ
      cate_id = Integer(socket.gets.chomp) 
      cat = $cats.find { |cat| cat[:id] == cate_id} 
      socket.puts cat.to_json

    when "CREATE" # CREATE
      name = socket.gets.chomp 
      cate_id = $id
      $id += 1
      $cats << {id: cate_id, name: name } 
    
    when "UPDATE"  # UPDATE
      cate_id = Integer(socket.gets.chomp) 
      cat = $cats.find { |cat| cat[:id] == cate_id } 
      new_name = socket.gets.chomp 
      cat[:name] = new_name

    when "DESTROY" # DESTROY
      cate_id = Integer(socket.gets.chomp) 
      $cats.reject! {|cat| cat[:id] == cate_id } 
    
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