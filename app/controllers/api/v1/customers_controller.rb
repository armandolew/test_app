module API
  module V1
    class CustomersController < API::ApiController

	  def balance
       render json: Services::CustomerServices::get_customer_balance.to_json
	  end

	  def pay
	  end
	end
  end
end