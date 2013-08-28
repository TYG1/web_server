require 'test/unit'
require_relative '../handle_client'


class TestFindContentType < Test::Unit::TestCase

  #########################

  # build response tests
  def test_build_response_200
    content_type = 'text/html'
    file = File.open(set_path('/'))
    status = HTTP_OK
    status_text = HTTP_OK_TEXT
    expected = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: 1165\r\nConnection: Keep-Alive\r\n\r\n" + file.read
    #file.read closes the file, stupid behavior
    file = File.open(set_path('/'))
    assert_equal expected, build_response(content_type, file, status, status_text)
  end


  def test_build_response_404
    content_type = 'text/html'
    file = File.open HTTP_NOT_FOUND_PATH
    status = HTTP_NOT_FOUND
    status_text = HTTP_NOT_FOUND_TEXT
    expected = "HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\nContent-Length: 331\r\nConnection: Keep-Alive\r\n\r\n" + file.read
    #file.read closes the file, stupid behavior
    file = File.open HTTP_NOT_FOUND_PATH
    assert_equal expected, build_response(content_type, file, status, status_text)
  end

  def test_build_response_500
    content_type = 'text/html'
    file = File.open HTTP_INTERNAL_SERVER_ERROR_PATH
    status = HTTP_INTERNAL_SERVER_ERROR
    status_text = HTTP_INTERNAL_SERVER_ERROR_TEXT
    expected = "HTTP/1.1 500 Internal Server Error\r\nContent-Type: text/html\r\nContent-Length: 107\r\nConnection: Keep-Alive\r\n\r\n" + file.read
    #file.read closes the file, stupid behavior
    file = File.open HTTP_INTERNAL_SERVER_ERROR_PATH
    assert_equal expected, build_response(content_type, file, status, status_text)
  end

  def test_build_response_501
    content_type = 'text/html'
    file = File.open HTTP_NOT_IMPLEMENTED_PATH
    status = HTTP_NOT_IMPLEMENTED
    status_text = HTTP_NOT_IMPLEMENTED_TEXT
    expected = "HTTP/1.1 501 Not Implemented\r\nContent-Type: text/html\r\nContent-Length: 205\r\nConnection: Keep-Alive\r\n\r\n" + file.read
    #file.read closes the file, stupid behavior
    file = File.open HTTP_NOT_IMPLEMENTED_PATH
    assert_equal expected, build_response(content_type, file, status, status_text)
  end
end