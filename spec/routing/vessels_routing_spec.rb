require "spec_helper"

describe VesselsController do
  describe "routing" do

    it "routes to #index" do
      get("/vessels").should route_to("vessels#index")
    end

    it "routes to #new" do
      get("/vessels/new").should route_to("vessels#new")
    end

    it "routes to #show" do
      get("/vessels/1").should route_to("vessels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vessels/1/edit").should route_to("vessels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vessels").should route_to("vessels#create")
    end

    it "routes to #update" do
      put("/vessels/1").should route_to("vessels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vessels/1").should route_to("vessels#destroy", :id => "1")
    end

  end
end
