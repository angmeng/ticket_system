require "spec_helper"

describe DeparturesController do
  describe "routing" do

    it "routes to #index" do
      get("/departures").should route_to("departures#index")
    end

    it "routes to #new" do
      get("/departures/new").should route_to("departures#new")
    end

    it "routes to #show" do
      get("/departures/1").should route_to("departures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/departures/1/edit").should route_to("departures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/departures").should route_to("departures#create")
    end

    it "routes to #update" do
      put("/departures/1").should route_to("departures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/departures/1").should route_to("departures#destroy", :id => "1")
    end

  end
end
