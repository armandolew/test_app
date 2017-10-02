module API
  class ApiController < ApplicationController 
    skip_before_action :verify_authenticity_token

    INITIAL_CONFIG  = {
      api_key: "testing",
      secret_key: "testing",
      version: "1.5"
    }


    def get_config(hash)
      INITIAL_CONFIG.merge(hash)
    end

    def get_service_response(config)
   	  cs       = ConnectionService.new(config)
  	  response = cs.get_response
    end

  end
end