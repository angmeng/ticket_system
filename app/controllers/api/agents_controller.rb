class Api::AgentsController < ApplicationController

  def show
  	agent = Agent.find_by_id params[:id]
  	return render :json => {:status => :success, :agent => agent.as_json}
  end

end