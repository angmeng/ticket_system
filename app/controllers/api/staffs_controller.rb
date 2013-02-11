class Api::StaffsController < ApplicationController
  skip_before_filter :authenticate_user!

 def authorize
    user = User.find_by_username_and_category_id(params[:username], UserType::MANAGER)
    if user
      if user.valid_password?(params[:password])
        return render :json => { :status => true, :message => "Transactions succesfully!", :manager_id => user.id }
      else
      	return render :json => { :status => false, :message => "Username & Password are invalid."}
      end
    else
      return render :json => { :status => false, :message => "User not found"}
    end
  end

end