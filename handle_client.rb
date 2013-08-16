WEB_FOLDER = 'web'
HTTP_OK = 200
HTTP_OK_TEXT = 'OK'

HTTP_NOT_IMPLEMENTED = 501
HTTP_NOT_IMPLEMENTED_PATH =  WEB_FOLDER + "/#{HTTP_NOT_IMPLEMENTED}.html"
HTTP_NOT_IMPLEMENTED_TEXT = 'Not Implemented'

HTTP_NOT_FOUND = 404
HTTP_NOT_FOUND_PATH = WEB_FOLDER + "/#{HTTP_NOT_FOUND}.html"
HTTP_NOT_FOUND_TEXT = 'Not Found'

HTTP_INTERNAL_SERVER_ERROR = 500
HTTP_INTERNAL_SERVER_ERROR_PATH = WEB_FOLDER + "/#{HTTP_INTERNAL_SERVER_ERROR}.html"
HTTP_INTERNAL_SERVER_ERROR_TEXT = 'Internal Server Error'


INDEX_PATH =  WEB_FOLDER + '/index.html'

def handle_client(client)
  keep_alive = true
  while keep_alive
    req = WEBrick::HTTPRequest.new(WEBrick::Config::HTTP)
    file = nil
    begin
      req.parse(client)
    rescue
      status = HTTP_NOT_IMPLEMENTED
      status_text = HTTP_NOT_IMPLEMENTED_TEXT
      file = File.open(HTTP_NOT_IMPLEMENTED_PATH)
    end

    if req.path.nil?
      close_connection(client) && return
    end

    #debug
    puts "Request path: #{req.path}"

    if req.path == "/"
      path = INDEX_PATH
    else
      path = WEB_FOLDER + req.path
    end

    #debug
    puts path

    puts 'starting file exists'
    if File.exists?(path)
      status = HTTP_OK
      status_text = HTTP_OK_TEXT
      file = File.open(path)
    elsif status != HTTP_NOT_IMPLEMENTED
      status = HTTP_NOT_FOUND
      status_text = HTTP_NOT_FOUND_TEXT
      file = File.open(HTTP_NOT_FOUND_PATH)
    end
    puts 'ending file exists'

    #find content type
    content_type = find_content_type(path)

    response = file.read
    header = "HTTP/1.1 #{status} #{status_text}\r\nContent-Type: #{content_type}\r\nContent-Length: #{response.length}\r\nConnection: Keep-Alive\r\n\r\n"
    response = header + response
    begin
    client.print(response)
    rescue
      close_connection(client)
      return # Send the time to the client
    end
    keep_alive = req.keep_alive?
    puts "Keep Alive? #{keep_alive}"
  end
  close_connection client
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

def close_connection(client)
  client.close
end