require 'rack' 

class RackApllication 
  def self.call(env) 
    # p env 
    http_status = 200
    headers = { 'Content-Type' => 'text/html' }
    body = ['hello world']

    [http_status, headers, body]
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
  app: SimpleServer, 
  Port: 3000
})