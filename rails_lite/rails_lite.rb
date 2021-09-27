require 'rack' 

class RackApllication 
  def self.call(env) 
    # p env 
   [200 ,{ 'Content-Type' => 'text/html' }, ['hello world'] ]
  end
end


class SimpleServer 

  def self.call(env)
    req = Rack::Request.new(env) 
    res = Rack::Response.new 

    name = req.params['name'] 

    res.write("hello #{name}") 
    res.finish
  end 
end 


Rack::Server.start({ 
  app: RackApllication, 
  Port: 3000
})