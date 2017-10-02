module API
  module V1
    class BillsController < API::ApiController

      def index
=begin
      	config   = get_config({endpoint: "bills", method: "GET"})
        response = get_service_response(config)

      	render json: { status: response[:code], message: response[:message] }
=end    

        customer_bills = customer.customer_bills.order("created_at DESC").
                           paginate(per_page: per_page, page: params[:page]) unless customer.nil?
        json_response(200, customer_bills)
      end

      private

        def customer
          @customer ||= Customer.find_by(id: params[:customer_id])
        end

        def per_page
          @per_page = params[:per_page].present? ? params[:per_page] : 10
        end

	end
  end    
end