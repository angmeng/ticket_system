class HomeController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:info]

  def index
  end

  def info
  	
  end
end
