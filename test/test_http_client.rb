# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/http_client'

class TestHttpClient < Minitest::Test

  def test_download
    client = Askg::HttpClient.new
    code, message = client.download('https://www.google.com/', 'test.html')
    puts code
    puts message
    assert_equal 200, code
    assert_equal 'OK', message
    assert_equal true, File.exist?('test.html')
    File.delete('test.html')
  end

end