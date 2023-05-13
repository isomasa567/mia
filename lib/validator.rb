# frozen_string_literal: true
require 'uri'

module Mia
  # バリデーションを行うクラス
  module Validator

    # emailアドレスを正規表現でチェックする
    # @param email [String] emailアドレス
    # @return [Boolean] true:正しいemailアドレス, false:不正なemailアドレス
    def self.email?(email)
      res = email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      res.nil? ? false : true
    end

    # 電話番号を正規表現でチェックする
    # xxx-xxxx-xxxx or xxxx-xx-xxxx
    # @param phone [String] 電話番号
    # @return [Boolean] true:正しい電話番号, false:不正な電話番号
    def self.phone?(phone)
      res = phone =~ /\A\d{2,4}-\d{2,4}-\d{3,4}\z|\A\d{2,4}-\d{2,4}\z/
      res.nil? ? false : true
    end

    # 郵便番号を正規表現でチェックする
    # xxx-xxxx or xxxxxxx
    # @param postal_code [String] 郵便番号
    # @return [Boolean] true:正しい郵便番号, false:不正な郵便番号
    def self.postal_code?(postal_code)
      res = postal_code =~ /\A\d{3}-\d{4}\z|\A\d{7}\z/
      res.nil? ? false : true
    end

    # URLを正規表現でチェックする
    # @param url [String] URL
    # @return [Boolean] true:正しいURL, false:不正なURL
    def self.url?(url)
      res = URI::regexp(%w[http https]) =~ url
      res.nil? ? false : true
    end

    # IPv4アドレスを正規表現でチェックする
    # @param ip [String] IPv4アドレス
    # @return [Boolean] true:正しいIPv4アドレス, false:不正なIPv4アドレス
    def self.ipv4_address?(ip)
      res = ip =~ /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/
      res.nil? ? false : true
    end

    # IPv6アドレスを正規表現でチェックする
    # @param ip [String] IPv6アドレス
    # @return [Boolean] true:正しいIPv6アドレス, false:不正なIPv6アドレス
    def self.ipv6_address?(ip)
      res = ip =~ /\A[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}:[0-9a-f]{1,4}\z/i
      res.nil? ? false : true
    end

  end

end