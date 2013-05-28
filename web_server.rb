require 'socket' # Get sockets from stdlib
require 'net/http'
require 'webrick'

LENGTH = 1024 *4

def handle_client(client)
  keep_alive = true
  while keep_alive
    index = File.open('web/index.html')
    status = 0
    req = WEBrick::HTTPRequest.new(WEBrick::Config::HTTP)
    file = nil
    begin
      req.parse(client)
    rescue
      status = 501
      file = File.open('web/501.html')
    end

    if req.path.nil?
      break
    end
    puts "Req path: #{req.path}"
    path = ''
    if req.path == "/"
      path = 'web/index.html'
    else
      path = 'web' + req.path
    end

    puts path

    if File.exists?(path)
      status = 200
      file = File.open(path)
    elsif status != 501
      status = 404
      File.open('web/404.html')
    end

    #find content type
    content_type = find_content_type(path)


    response = file.read
    header = "HTTP/1.1 200 OK\r\nContent-Type: #{content_type}\r\nContent-Length: #{response.length}\r\nConnection: Keep-Alive\r\n\r\n"
    response = header + response
    client.print(response) rescue return# Send the time to the client
    keep_alive = req.keep_alive?
    puts "Keep Alive? #{keep_alive}"
  end
  client.close
end


def find_content_type(path)
  extension = path.split('.')[-1]
  if extension == 'html'
    content_type = 'text/html'
  elsif extension == 'css'
    content_type = 'text/css'
  elsif extension == 'jpg'
    content_type = 'image/jpeg'
  elsif extension == 'png'
    content_type = 'image/png'
  else
    content_type = 'text/plain'
  end
end


# MAIN

if ARGV[0].nil?
  abort 'Usage: ruby web_server.rb [port_number]'
end

server = TCPServer.open(ARGV[0])
loop {
  client = server.accept
  handle_client(client)

}

=begin
loop {
  Thread.start(server.accept) do |client|
    handle_client(client)
  end
}
=end