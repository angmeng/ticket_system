class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  protected

  ["is_manager?", "is_staff?", "is_agent?", "is_user?", "is_sub_agent?"].each do |m|
    define_method m do
      current_user && current_user.send(m)
    end
     helper_method :"#{m}"
  end

  def is_admin?
  	current_user && (current_user.is_manager? || current_user.is_staff?)
  end
  helper_method :is_admin?

  # def is_staff?
  # 	current_user && current_user.is_staff?	
  # end
  # helper_method :is_staff?

  # def is_agent?
  #   current_user && current_user.is_agent?  
  # end
  # helper_method :is_agent?

  # def is_user?
  #   current_user && current_user.is_user?  
  # end
  # helper_method :is_user?

  def after_sign_in_path_for(resource)
    if is_user?
      dashboard_index_url
    elsif is_agent?
      dashboard_index_url
    elsif is_staff?
      dashboard_index_url
    elsif is_manager?
      dashboard_index_url
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    home_info_url
  end
end
