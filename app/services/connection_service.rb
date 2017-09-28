require 'base64'
require 'digest'

class ConnectionService
  
  attr_accessor :endpoint, :method, :params, :api_key, :api_secret, :body, :version
  attr_reader   :timestamp, :content_type

  CONTENT_TYPE  = 'application/json'.freeze
  METHODS_ARRAY = ["GET", "POST"]

  def initialize(config = {})
    @api_key      = config[:api_key]
    @api_secret   = config[:api_secret]
    @body         = config[:body]
    @endpoint     = config[:endpoint]
    @method       = config[:method]
    @params       = config[:params]
    @version      = config[:version]
  end

  def get_response
  	return nil if !valid_connection_service_object?
    response = send(get_method)
    format_response(response)
  end

  def get_params_values
    self.params
  end

  private 

    def valid_endpoint?
      !self.endpoint.nil? && !self.endpoint.empty?
    end

    def valid_method?
      !self.method.nil? && !self.method.empty? && METHODS_ARRAY.include?(self.method)
    end

    def valid_connection_service_object?
      return true if (valid_endpoint? && valid_method?)
    end

    def get
      response = HTTParty.get(get_url, :headers => define_headers)
    end

    def post
      response = HTTParty.post(get_url, :headers => define_headers)
    end

    def define_headers
      {
        "Accept"        => get_version,
        "Content-Type"  => CONTENT_TYPE,
        "Content-MD5"   => "#{content_md5}",
        "Date"          => get_timestamp,
        "Authorization" => checksum
      }
    end

    def checksum
      digest = OpenSSL::Digest.new('sha1')
      auth   = Base64.strict_encode64(OpenSSL::HMAC.digest(digest, self.api_secret, canonical_string))

      "APIAuth #{self.api_key}:#{auth}"
    end

    def canonical_string
      [CONTENT_TYPE, content_md5, self.endpoint, get_timestamp].join(',')
    end

    def get_version
      "application/vnd.regalii.v#{self.version}+json"
    end

    def content_md5
      Digest::MD5.base64digest(self.body) if self.body
    end

    def get_url
      URI.parse("http://localhost:3000/#{self.endpoint}")
    end

    def get_method
      self.method.underscore
    end

    def get_timestamp
      Time.now.utc.httpdate.to_s
    end

    def format_response(response)
      {
        code:    response.code,
        message: response.body
      }
    end

end