require 'socket' # Get sockets from stdlib
require 'net/http'
require 'webrick'

LENGTH = 1024 *4

def handle_client(client)
  index = File.open('web/index.html')
  status = 0
  req = WEBrick::HTTPRequest.new(WEBrick::Config::HTTP)
  begin
    req.parse(client)
  rescue
    status = 501
  end

  path = ''
  if req.path == "/"
    path = 'web/index.html'
  else
    path = 'web' + req.path
  end

  puts path

  if File.exists?(path)
    status = 200
  elsif status != 501
    status = 404
  end


  response = index.read
  header = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: #{response.length}\r\nConnection: Keep-Alive\r\n\r\n"
  response = header + response
  client.print(response) # Send the time to the client
  client.close # Disconnect from the client
end


if ARGV[0].nil?
  abort 'Usage: ruby web_server.rb [port_number]'
end

server = TCPServer.open(ARGV[0])
loop {
  Thread.start(server.accept) do |client|
    handle_client(client)
  end
}