class HomeController < ApplicationController
	skip_before_filter :authenticate_user!, :only => [:index]

  def index
  end

  def info
  end

  def access_denied
  	
  end
end
