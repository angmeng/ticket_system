class Api::StaffsController < ApplicationController

 def authorize
    user = User.find_by_username_and_category_id(params[:username], UserType::MANAGER)
    if user
      if user.valid_password?(params[:password])
        return render(:text => {:status => true,  :message => "Transactions succesfully!", :layout => false, :manager_id => user.id }.to_json)
      else
      	return render(:text => {:status => false,  :message => "Username & Password are invalid.", :layout => false}.to_json)
      end
    else
      return render(:text => {:status => false,  :message => "User not found", :layout => false}.to_json)
    end
  end

end