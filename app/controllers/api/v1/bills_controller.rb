module API
  module V1
    class BillsController < API::ApiController

      def index
      	config   = get_config({endpoint: "bills", method: "GET"})
        response = get_service_response(config)

      	render json: { status: response[:code], message: response[:message] }
      end

	end
  end    
end