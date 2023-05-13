# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/http_client'

class TestHttpClient < Minitest::Test

  def test_download
    client = Mia::HttpClient.new
    code, message = client.download('https://www.google.com/', 'test.html')
    puts code
    puts message
    assert_equal 200, code
    assert_equal 'OK', message
    assert_equal true, File.exist?('test.html')
    File.delete('test.html')
  end

  def test_post_json
    client = Mia::HttpClient.new
    code, message = client.post_json('http://httpbin.org/post', '{"test": "test"}')
    puts code
    puts message
    assert_equal 200, code
  end

end