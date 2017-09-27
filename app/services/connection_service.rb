class ConnectionService
  
  attr_accessor :url, :method, :params, :api_key, :api_secret

  METHODS_ARRAY = ["GET", "POST"]

  def initialize(config ={})
    @url        = config[:url]
    @method     = config[:method]
    @params     = config[:params]
    @api_key    = config[:api_key]
    @api_secret = config[:api_secret]
  end

  def get_connection
  	#return nil if !valid_connection_service_object?
    case self.method
      when "GET"  then get
      when "POST" then post
    end
  end

  def get_params_values
    self.params
  end

  def valid_connection_service_object?
  	return false unless (valid_url? && valid_method?)
  end

  private 

    def valid_url?
      !self.url.nil? && !self.url.empty?
    end

    def valid_method?
      !self.method.nil? && !self.method.empty? && METHODS_ARRAY.include?(self.method)
    end

    def get
      response = HTTParty.get(self.url)
    end

    def post
      response = HTTParty.post(self.url)
    end



end