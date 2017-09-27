require 'spec_helper'

RSpec.describe ConnectionService do
  before :all do
    @good_connection_response = ConnectionService.new.get_connection("http://localhost:3000")
    @bad_connection_response =ConnectionService.new.get_connection("http://www.googlecom.com.com")
  end
  describe "#get_connection" do
    context "when asking for a remote connection" do
      it "returns a good response" do
        expect(@good_connection_response).should_not nil
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