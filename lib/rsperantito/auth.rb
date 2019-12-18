require 'json'
require 'restclient'
require 'addressable'

module RSperantito
  class ExceptionAuthenticate < StandardError; end

  API_URI = 'https://api.sperant.com/v2/'.freeze
  TOKEN_URI = 'https://api.sperant.com/oauth/token'.freeze
  VERBS         = %w[get post put delete].freeze

  class << self
    attr_reader :client_token

    def authenticate(client_id, client_secret)
      @client_id, @client_secret = client_id, client_secret
      params =
        {grant_type: 'client_credentials',
          client_id: @client_id,
          client_secret: @client_secret}

      response = RestClient::Resource.new(
        TOKEN_URI,
        verify_ssl: false).post(params)
      @client_token = JSON.parse(response)['access_token']
      true
    end

    VERBS.each do |verb|
      define_method verb  do |path, *params|
        params << {'Authorization' => "Bearer #{client_token}"}
        send_request(verb, path, *params)
      end
    end

    private

    def send_request(verb, path, *params)
      url = path.start_with?('http') ? path : API_URI + path
      url, query = *url.split('?')
      url = Addressable::URI.encode(url)
      url << "?#{query}" if query

      begin
        headers = get_headers(params)

        response = RestClient::Resource.new(
          url,
          headers: headers,
          verify_ssl: false).send(verb, *params)
      rescue RestClient::Unauthorized => e

        raise ExceptionAuthenticate unless @client_token
        authenticate(@client_id, @client_secret)
        headers = get_headers(params)
        headers['Authorization'] = "Bearer #{@client_token}"
        response = retry_connection(verb, url, params)
      end

      JSON.parse(response) unless response.nil? || response.empty?
    end

    def retry_connection(verb, url, params)
      RestClient.send(verb, url, *params)
    end

    def get_headers(params)
      params.find{|param| param.is_a?(Hash) && param['Authorization']}
    end
  end
end
