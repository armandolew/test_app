module API
  module V1
    class CustomersController < API::ApiController

	  def balance
	   cs = CustomerService.new(connection_service_params: params)
	   render json: cs.get_customer_balance.to_json
       #render json: Services::CustomerServices::get_customer_balance.to_json
	  end

	  def pay
	  end


	end
  end
end