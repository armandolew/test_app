require 'base64'
require 'digest'

class ConnectionService
  
  attr_accessor :api_key, :secret_key, :body, :endpoint, :method, :params, :version

  # Constants ------------------------------------------------

  CONTENT_TYPE  = "application/json".freeze
  METHODS_ARRAY = ["GET", "POST"]

  # Initial settings -----------------------------------------

  def initialize(config = {})
    @api_key      = config[:api_key]
    @secret_key   = config[:secret_key]
    @body         = config[:body]
    @endpoint     = config[:endpoint]
    @method       = config[:method]
    @params       = config[:params]
    @version      = config[:version]
  end

  # Response -------------------------------------------------

  def get_response
  	return { code: 400, message: "Insufficient Params" } if !valid_connection_service_object?
    response = send(get_method)
    format_response(response)
  end

  private 

    # Validations --------------------------------------------

    def valid_api_key?
      !self.api_key.nil? && !self.api_key.empty?
    end

    def valid_secret_key?
      !self.secret_key.nil? && !self.secret_key.empty?
    end    

    def valid_endpoint?
      !self.endpoint.nil? && !self.endpoint.empty?
    end

    def valid_method?
      !self.method.nil? && 
        !self.method.empty? && 
          METHODS_ARRAY.include?(self.method)
    end

    def valid_connection_service_object?
      valid_api_key? && 
        valid_secret_key? && 
          valid_endpoint? && 
            valid_method?
    end

    # HTTP methods -------------------------------------------

    def get
      response = HTTParty.get(get_url, :headers => define_headers)
    end

    def post
      response = HTTParty.post(get_url, :headers => define_headers)
    end

    # Utils --------------------------------------------------

    def canonical_string
      [CONTENT_TYPE, content_md5, self.endpoint, get_timestamp].join(',')
    end

    def checksum
      digest = OpenSSL::Digest.new('sha1')
      auth   = Base64.strict_encode64(OpenSSL::HMAC.digest(digest, self.secret_key, canonical_string))

      "APIAuth #{self.api_key}:#{auth}"
    end

    def content_md5
      Digest::MD5.base64digest(self.body) if self.body
    end

    def define_headers
      {
        "Accept"        => get_version,
        "Authorization" => checksum,
        "Content-MD5"   => "#{content_md5}",
        "Content-Type"  => CONTENT_TYPE,
        "Date"          => get_timestamp
      }
    end

    def format_response(response)
      {
        code:    response.code,
        message: response.body
      }
    end

    def get_url
      URI.parse("http://localhost:3000/#{self.endpoint}")
    end

    def get_timestamp
      Time.now.utc.httpdate.to_s
    end

    def get_method
      self.method.underscore
    end

    def get_version
      "application/vnd.regalii.v#{self.version}+json"
    end

end