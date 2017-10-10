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

      def show
        render json: customer
      end

      def index
        render json: Customer.order('created_at DESC').paginate(per_page: per_page, page: params[:page])
      end

      private

        def customer
          @customer ||= Customer.find_by(id: params[:id])
        end

        def per_page
          @per_page = params[:per_page].present? ? params[:per_page] : 10
        end 

	  end
  end
end