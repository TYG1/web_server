require_relative 'http_constants'

def set_path(req)
  if req.path == '/'
    INDEX_PATH
  else
    WEB_FOLDER + req.path
  end
end

def build_response(content_type, file, status, status_text)
  response = file.read
  header = "HTTP/1.1 #{status} #{status_text}\r\nContent-Type: #{content_type}\r\nContent-Length: #{response.length}\r\nConnection: Keep-Alive\r\n\r\n"
  header + response
end

def find_content_type(path)
  extension = path.split('.')[-1]
  case extension
    when 'html'
      content_type = 'text/html'
    when 'css'
      content_type = 'text/css'
    when 'jpg'
      content_type = 'image/jpeg'
    when 'png'
      content_type = 'image/png'
    else
      content_type = 'text/plain'
  end

end


def close_connection(client)
  client.close
end

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

    path = set_path(req)

    #debug
    puts path

    if File.exists?(path)
      status = HTTP_OK
      status_text = HTTP_OK_TEXT
      file = File.open(path)
    elsif status != HTTP_NOT_IMPLEMENTED
      status = HTTP_NOT_FOUND
      status_text = HTTP_NOT_FOUND_TEXT
      file = File.open(HTTP_NOT_FOUND_PATH)
    end

    #find content type
    content_type = find_content_type(path)

    response = build_response(content_type, file, status, status_text)
    begin
      client.print(response)
    rescue
      close_connection(client) and return
    end
    keep_alive = req.keep_alive?

    #debug
    puts "Keep Alive? #{keep_alive}"
  end
  close_connection client
end


