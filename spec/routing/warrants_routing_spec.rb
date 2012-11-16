require "spec_helper"

describe WarrantsController do
  describe "routing" do

    it "routes to #index" do
      get("/warrants").should route_to("warrants#index")
    end

    it "routes to #new" do
      get("/warrants/new").should route_to("warrants#new")
    end

    it "routes to #show" do
      get("/warrants/1").should route_to("warrants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/warrants/1/edit").should route_to("warrants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/warrants").should route_to("warrants#create")
    end

    it "routes to #update" do
      put("/warrants/1").should route_to("warrants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/warrants/1").should route_to("warrants#destroy", :id => "1")
    end

  end
end
