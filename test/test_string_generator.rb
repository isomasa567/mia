# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/string_generator'

class TestStringGenerator< Minitest::Test

  def test_guid
    assert_equal 36, Askg::StringGenerator.guid.length
  end

  def test_guid_without_dash
    assert_equal 32, Askg::StringGenerator.guid_without_dash.length
    assert_equal true, !Askg::StringGenerator.guid_without_dash.include?('-')
  end

  def test_random_string
    assert_equal true, Askg::StringGenerator.random_string(nil).length == 0
    assert_equal 10, Askg::StringGenerator.random_string(10).length
  end

  def test_random_string_only_lower
    assert_equal true, Askg::StringGenerator.random_string_only_lower(nil).length == 0
    assert_equal 10, Askg::StringGenerator.random_string_only_lower(10).length

    #　全て小文字と数字かチェック
    assert_equal true, Askg::StringGenerator.random_string_only_lower(10).match?(/^[a-z0-9]+$/)
  end

  def test_random_string_with_symbol
    assert_equal true, Askg::StringGenerator.random_string_with_symbol(nil).length == 0
    assert_equal 10, Askg::StringGenerator.random_string_with_symbol(10).length
    assert_equal true, Askg::StringGenerator.random_string_with_symbol(10).match?(/^[a-z0-9!-~]+$/)
    assert_equal true, Askg::StringGenerator.random_string_with_symbol(10, max_symbol_length: 2).length == 10
    assert_equal true, Askg::StringGenerator.random_string_with_symbol(10, max_symbol_length: 11).length == 10
    assert_equal "", Askg::StringGenerator.random_string_with_symbol(0)
    assert_equal true, Askg::StringGenerator.random_string_with_symbol(1).match?(/^[a-z0-9!-~]+$/)
  end

end
