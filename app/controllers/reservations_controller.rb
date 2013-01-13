class ReservationsController < ApplicationController
  def index
  end

  def new
  	@jetties = Jetty.order(:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end
end
