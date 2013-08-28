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

  def test_set_path_jpg
    path = '/images/kodim20.jpg'
    expected =  WEB_FOLDER + path
    assert_equal set_path(path), expected
  end

  def test_set_path_png
    path = '/images/kodim20.png'
    expected =  WEB_FOLDER + path
    assert_equal set_path(path), expected
  end
  #######################


  # file exists tests
  def test_file_exists_png
    path = 'web/images/kodim20.png'
    expected =  true
    assert_equal file_exists?(path), expected
  end

  def test_file_exists_jpg
    path = 'web/images/kodim20.jpg'
    expected =  true
    assert_equal file_exists?(path), expected
  end

  def test_file_exists_index
    path = 'web/index.html'
    expected =  true
    assert_equal file_exists?(path), expected
  end

  def test_file_exists_simple
    path = 'web/simple.html'
    expected =  true
    assert_equal file_exists?(path), expected
  end

  def test_file_exists_404
    path = 'web/404.html'
    expected =  true
    assert_equal file_exists?(path), expected
  end

  def test_non_exist_file1
    path = 'web/432404.html'
    expected =  false
    assert_equal file_exists?(path), expected
  end

  def test_non_exist_file2
    path = 'web/404....html'
    expected =  false
    assert_equal file_exists?(path), expected
  end

  def test_non_exist_file3
    path = 'web/404.htmlg'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file4
    path = 'web/404.jpg'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file5
    path = 'web/simple/.html'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file6
    path = 'web/432404////.html'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file7
    path = 'web/432404.htdsml'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file8
    path = 'web/502.html'
    expected =  false
    assert_equal file_exists?(path), expected
  end
  def test_non_exist_file9
    path = 'web/wewq.html'
    expected =  false
    assert_equal file_exists?(path), expected
  end



  #######################
end