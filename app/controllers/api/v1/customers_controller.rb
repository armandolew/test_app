module API
  module V1
    class CustomersController < API::ApiController

	  def balance
      	config   = get_config({endpoint: "customer_bills", method: "POST"})
      	cs       = ConnectionService.new(config)
      	response = cs.get_response
      	
      	render json: { status: response[:code], message: response[:message] }
	  end

	  def pay
	  end


	end
  end
end