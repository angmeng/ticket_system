require "spec_helper"

describe JettiesController do
  describe "routing" do

    it "routes to #index" do
      get("/jetties").should route_to("jetties#index")
    end

    it "routes to #new" do
      get("/jetties/new").should route_to("jetties#new")
    end

    it "routes to #show" do
      get("/jetties/1").should route_to("jetties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/jetties/1/edit").should route_to("jetties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/jetties").should route_to("jetties#create")
    end

    it "routes to #update" do
      put("/jetties/1").should route_to("jetties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/jetties/1").should route_to("jetties#destroy", :id => "1")
    end

  end
end
