require "spec_helper"

describe ReservationDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/reservation_details").should route_to("reservation_details#index")
    end

    it "routes to #new" do
      get("/reservation_details/new").should route_to("reservation_details#new")
    end

    it "routes to #show" do
      get("/reservation_details/1").should route_to("reservation_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reservation_details/1/edit").should route_to("reservation_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reservation_details").should route_to("reservation_details#create")
    end

    it "routes to #update" do
      put("/reservation_details/1").should route_to("reservation_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reservation_details/1").should route_to("reservation_details#destroy", :id => "1")
    end

  end
end
