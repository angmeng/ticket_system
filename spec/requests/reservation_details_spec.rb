require 'spec_helper'

describe "ReservationDetails" do
  describe "GET /reservation_details" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get reservation_details_path
      response.status.should be(200)
    end
  end
end
