class ExceptionHandlerController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
  end

  def access_denied
  end
end
