require "spec_helper"

describe OrderItemDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/order_item_details").should route_to("order_item_details#index")
    end

    it "routes to #new" do
      get("/order_item_details/new").should route_to("order_item_details#new")
    end

    it "routes to #show" do
      get("/order_item_details/1").should route_to("order_item_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/order_item_details/1/edit").should route_to("order_item_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/order_item_details").should route_to("order_item_details#create")
    end

    it "routes to #update" do
      put("/order_item_details/1").should route_to("order_item_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/order_item_details/1").should route_to("order_item_details#destroy", :id => "1")
    end

  end
end
