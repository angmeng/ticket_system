require "spec_helper"

describe WarrantPurchasesController do
  describe "routing" do

    it "routes to #index" do
      get("/warrant_purchases").should route_to("warrant_purchases#index")
    end

    it "routes to #new" do
      get("/warrant_purchases/new").should route_to("warrant_purchases#new")
    end

    it "routes to #show" do
      get("/warrant_purchases/1").should route_to("warrant_purchases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/warrant_purchases/1/edit").should route_to("warrant_purchases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/warrant_purchases").should route_to("warrant_purchases#create")
    end

    it "routes to #update" do
      put("/warrant_purchases/1").should route_to("warrant_purchases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/warrant_purchases/1").should route_to("warrant_purchases#destroy", :id => "1")
    end

  end
end
