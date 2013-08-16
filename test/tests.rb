require 'test/unit'
require_relative '../handle_client'


class TestFindContentType < Test::Unit::TestCase
  def test_html
    path = '/simple.html'
    expected = 'text/html'
    assert_equal expected, find_content_type(path)
  end


end