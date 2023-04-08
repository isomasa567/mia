# frozen_string_literal: true

require 'test_helper'

class TestValidator < Minitest::Test

  def test_email
    assert_equal true, Askg::Validator.email?('tttt@emai.com')
    assert_equal false, Askg::Validator.email?('tttt@emai')
    assert_equal false, Askg::Validator.email?('tttt#tetest')
  end

  def test_phone
    assert_equal true, Askg::Validator.phone?('090-1234-5678')
    assert_equal true, Askg::Validator.phone?('0123-44-5678')
    assert_equal false, Askg::Validator.phone?('09012345678')
    assert_equal false, Askg::Validator.phone?('090123456789')
    assert_equal false, Askg::Validator.phone?('0901234567')
  end

  def test_postal_code
    assert_equal true, Askg::Validator.postal_code?('123-4567')
    assert_equal true, Askg::Validator.postal_code?('1234567')
    assert_equal false, Askg::Validator.postal_code?('123-456')
    assert_equal false, Askg::Validator.postal_code?('123456')
    assert_equal false, Askg::Validator.postal_code?('12345678')
  end

  def test_url
    assert_equal true, Askg::Validator.url?('http://www.example.com')
    assert_equal true, Askg::Validator.url?('https://www.example.com')
    assert_equal false, Askg::Validator.url?('www.example.com')
    assert_equal false, Askg::Validator.url?('example.com')
  end

  def test_ipv4_address
    assert_equal true, Askg::Validator.ipv4_address?('127.0.0.1')
    assert_equal false, Askg::Validator.ipv4_address?('000,0,0,01')
    assert_equal false, Askg::Validator.ipv4_address?('127.0,0,1')
  end

  def test_ipv6_address
    assert_equal true, Askg::Validator.ipv6_address?('2001:0db8:85a3:0000:0000:8a2e:0370:7334')
    assert_equal true, Askg::Validator.ipv6_address?('2001:db8:85a3:0:0:8a2e:370:7334')
    assert_equal false, Askg::Validator.ipv6_address?('2001:db8:85a3:8a2e:370:7334')
    assert_equal false, Askg::Validator.ipv6_address?('2001:db8:85a3:0:0:8a2e:370:7334:1')
  end


end
