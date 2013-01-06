require 'spec_helper'

describe ExceptionHandlerController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'access_denied'" do
    it "returns http success" do
      get 'access_denied'
      response.should be_success
    end
  end

end
