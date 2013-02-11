class Api::AgentsController < ApplicationController
	skip_before_filter :authenticate_user!

  def show
  	agent = Agent.find_by_id params[:id]
  	return render :json => {:status => :success, :agent => agent.as_json}
  end

end