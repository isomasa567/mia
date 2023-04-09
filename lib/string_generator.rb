# frozen_string_literal: true

require_relative "askg/version"
require 'securerandom'

module Askg
  class Error < StandardError; end

  module StringGenerator

    # Guidを生成する
    # @return [String] Guid
    def self.guid
      SecureRandom.uuid
    end

    # Guidを生成する.ハイフンを除く
    # @return [String] Guid
    def self.guid_without_dash
      SecureRandom.uuid.gsub('-', '')
    end

    # 指定桁数のランダムな文字列を生成する
    # @param length [Integer] 文字列の桁数
    # @return [String] ランダムな文字列
    def self.random_string(length)
      length = length.to_i
      return '' if length < 1
      SecureRandom.alphanumeric(length)
    end

    # 指定桁数のランダムな文字列を生成する.小文字のみ
    # @param length [Integer] 文字列の桁数
    # @return [String] ランダムな文字列
    def self.random_string_only_lower(length)
      length = length.to_i
      return '' if length < 1
      SecureRandom.alphanumeric(length).downcase
    end

    # 指定桁数のランダムな文字列を生成する.記号を含む
    # @param length [Integer] 文字列の桁数
    # @param max_symbol_length [Integer] 記号の最大桁数 (default: 1-length)
    def self.random_string_with_symbol(length, max_symbol_length: 1)
      length = length.to_i
      max_symbol_length = max_symbol_length.to_i

      return '' if length < 1

      # 記号文字数をランダムに決める
      symbol_count = rand(1..max_symbol_length)

      value = length - symbol_count > 0 ? SecureRandom.alphanumeric(length - symbol_count) : ''
      value = value + make_symbol_strings.sample(symbol_count).join

      # 文字列をシャッフルする
      value.chars.shuffle.join
    end

    # 記号文字の配列を返す
    def self.make_symbol_strings
      %w[! " # $ % & ' ( ) * + , - . : ; < = > ? @ [ ] ^ _  ~]
    end
  end

end
