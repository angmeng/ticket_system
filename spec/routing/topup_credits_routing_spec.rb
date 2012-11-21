require "spec_helper"

describe TopupCreditsController do
  describe "routing" do

    it "routes to #index" do
      get("/topup_credits").should route_to("topup_credits#index")
    end

    it "routes to #new" do
      get("/topup_credits/new").should route_to("topup_credits#new")
    end

    it "routes to #show" do
      get("/topup_credits/1").should route_to("topup_credits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/topup_credits/1/edit").should route_to("topup_credits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/topup_credits").should route_to("topup_credits#create")
    end

    it "routes to #update" do
      put("/topup_credits/1").should route_to("topup_credits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/topup_credits/1").should route_to("topup_credits#destroy", :id => "1")
    end

  end
end
