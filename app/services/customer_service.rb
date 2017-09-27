class CustomerService

  attr_accessor :connection_service_params

  def initialize(connection_service_params: params)
  	@connection_service_params = connection_service_params
  end

  def get_customer_balance
    connection_service.get_connection
  end


  private
    def connection_service
      @connection_service ||= ConnectionService.new(self.connection_service_params)
    end



end