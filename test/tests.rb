require 'test/unit'
require_relative '../handle_client'


class TestHandleClient < Test::Unit::TestCase
  def test_html
    path = '/simple.html'
    expected = 'text/html'
    assert_equal expected, find_content_type(path)
  end

  def test_css
    path = '/simple.css'
    expected = 'text/css'
    assert_equal expected, find_content_type(path)
  end

  def test_set_path_root
    path = '/'
    expected =  INDEX_PATH
    assert_equal set_path(path),  expected
  end

  def test_set_path_page
    path = '/blah.html'
    expected =  WEB_FOLDER + path
    assert_equal set_path(path), expected
  end

end