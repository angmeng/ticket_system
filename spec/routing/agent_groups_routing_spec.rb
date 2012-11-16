require "spec_helper"

describe AgentGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/agent_groups").should route_to("agent_groups#index")
    end

    it "routes to #new" do
      get("/agent_groups/new").should route_to("agent_groups#new")
    end

    it "routes to #show" do
      get("/agent_groups/1").should route_to("agent_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/agent_groups/1/edit").should route_to("agent_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/agent_groups").should route_to("agent_groups#create")
    end

    it "routes to #update" do
      put("/agent_groups/1").should route_to("agent_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/agent_groups/1").should route_to("agent_groups#destroy", :id => "1")
    end

  end
end
