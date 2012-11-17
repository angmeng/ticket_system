class UsersController < ApplicationController
  def index
  	@users = User.where("category_id = ?", UserType::USER)
  end

  def show
  	@user = User.find params[:id]
  end

  def edit
  	@user = User.find params[:id]
  end

  def profile
    @user = User.find params[:id]
  end

  def update
  	@user = User.find params[:id]
    puts request.referer
  	if @user.update_attributes params[:user]
  	  flash[:notice] = "Successfully updated"
      if request.referer.include? "profile"
        redirect_to profile_user_path(@user)
      else
  	    redirect_to @user
      end
  	else
  	  render "edit"
  	end
  end

  def destroy
  	flash[:error] = "Temporary cannot delete user"
  	redirect_to :back
  end

end
