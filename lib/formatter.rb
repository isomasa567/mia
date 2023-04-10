# frozen_string_literal: true

require 'json'

module Askg
  module Formatter

    # UnixPath文字列をWindowsPath文字列に変換する
    # @param path [String] UnixPath文字列
    # @return [String] WindowsPath文字列
    def self.unix_to_windows_path(path)
      path.to_s.gsub('/', '\\')
    end

    # WindowsPath文字列をUnixPath文字列に変換する
    # @param path [String] WindowsPath文字列
    # @return [String] UnixPath文字列
    def self.windows_to_unix_path(path)
      path.to_s.gsub('\\', '/')
    end

    # JSON文字列を改行付きで整形する
    # @param json [String] JSON文字列
    # @return [String] 整形後のJSON文字列
    def self.format_json(json)
      JSON.pretty_generate(JSON.parse(json.to_s))
    end

    # CR+LFをLFに変換する
    # @param text [String] テキスト
    # @return [String] 変換後のテキスト
    def self.convert_crlf_to_lf(text)
      text.to_s.gsub(/\r\n/, "\n")
    end

    # LFをCR+LFに変換する
    # @param text [String] テキスト
    # @return [String] 変換後のテキスト
    def self.convert_lf_to_crlf(text)
      text.to_s.gsub(/\n/, "\r\n")
    end

  end

end