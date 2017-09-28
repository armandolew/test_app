require 'spec_helper'

RSpec.describe ConnectionService do
  before :all do
    @config = {url: "http://localhost:3000/bills", method: "GET", api_key: "testing", api_secret: "testing"}
    cs      = ConnectionService.new(config)
    @bad_connection_response = cs.get_connection
  end
  describe "#get_connection" do
    context "when asking for a remote connection" do
      it "returns a good response" do
        expect(@bad_connection_response).should_not nil
      end

      it "returns a bad response" do
        expect(@bad_connection_response).should nil
      end

      it "should not be a good response" do
        expect(@bad_connection_response).should_not nil
      end

    end
  end
end