# frozen_string_literal: true
require 'net/http'
require 'net/https'

module Mia
  class HttpClient

    def initialize(proxy_uri: nil, open_timeout: 5, read_timeout: 5)
      @proxy_uri = proxy_uri
      @open_timeout = open_timeout
      @read_timeout = read_timeout
    end

    # post_json
    # @param uri [String] URI
    # @param json_str [String] JSON String
    # @return [Array] [Response Code, Response Message]
    def post_json(uri, json_str)
      parsed_uri, http = create(uri, proxy_uri: @proxy_uri, open_timeout: @open_timeout, read_timeout: @read_timeout)
      req = Net::HTTP::Post.new(parsed_uri.request_uri)
      req["Content-Type"] = "application/json"
      req.body = json_str
      response = http.request(req)
      [response.code.to_i, response.body]
    end

    # download
    # @param uri [String] URI
    # @param download_path [String] Download Path
    # @return [Array] [Response Code, Response Message]
    def download(uri, download_path)
      response_code = 0
      response_message = ''

      parsed_uri, http = create(uri, proxy_uri: @proxy_uri, open_timeout: @open_timeout, read_timeout: @read_timeout)
      return response_code, response_message if parsed_uri.nil? || http.nil?

      req = Net::HTTP::Get.new(parsed_uri.request_uri)
      http.request(req) do |response|
        if response.is_a? Net::HTTPSuccess
          File.open(download_path, 'wb') do |file|
            response.read_body do |chunk|
              file.write(chunk)
            end
          end
        end
        response_code = response.code.to_i
        response_message = response.message
      end

      [response_code, response_message]
    end

    private

    # Create HTTP Client
    # @param uri [String] URI
    # @param proxy_uri [String] Proxy URI
    # @param open_timeout [Integer] Open Timeout
    # @param read_timeout [Integer] Read Timeout
    # @return [Array] [URI, Net::HTTP]
    def create(uri, proxy_uri: nil, open_timeout: 5, read_timeout: 5)
      parsed_uri = URI.parse(uri)
      if parsed_uri.to_s == ""
        puts "URI parse error. uri=>#{uri}"
        return nil, nil
      end

      http = if proxy_uri.to_s.length > 0
               parsed_proxy_uri = URI.parse(proxy_uri.to_s)
               if parsed_proxy_uri.to_s.empty?
                 puts "URI parse error. proxy_uri=>#{proxy_uri}"
                 return nil, nil
               end

               proxy_class = Net::HTTP::Proxy(parsed_proxy_uri.host.to_s, parsed_proxy_uri.port)
               proxy_class.new(parsed_uri.host, parsed_uri.port)
             else
               Net::HTTP.new(parsed_uri.host.to_s, parsed_uri.port)
             end

      http.open_timeout = open_timeout
      http.read_timeout = read_timeout

      if parsed_uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
      [parsed_uri, http]
    end
  end
end