require 'test/unit'
require_relative '../handle_client'
require_relative 'test_build_response'
require_relative 'test_find_content_type'


class TestHandleClient < Test::Unit::TestCase

  #set path tests
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
  #######################



end