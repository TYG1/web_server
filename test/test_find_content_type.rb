require 'test/unit'
require_relative '../handle_client'


class TestFindContentType < Test::Unit::TestCase

  # Test find content type
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

  def test_jpg
    path = '/simple.jpg'
    expected = 'image/jpeg'
    assert_equal expected, find_content_type(path)
  end

  def test_png
    path = '/simple.png'
    expected = 'image/png'
    assert_equal expected, find_content_type(path)
  end

  def test_text
    path = '/simple.txt'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other
    path = '/simple.pndsadsag'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other1
    path = '/simple.htmi'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other2
    path = '/simpsadsag'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other3
    path = '/simple.2321ewfewf'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other4
    path = '/simple.....pndsawdwq'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other5
    path = 'simple.pndsadsag'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other6
    path = '4'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other7
    path = '////simple.pndsadsag'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

  def test_other8
    path = '/simp////le.pndsadsag'
    expected = 'text/plain'
    assert_equal expected, find_content_type(path)
  end

end