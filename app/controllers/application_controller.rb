class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  helper_method :selection_routine
  def selection_routine
    @selection_routine ||= Routine.all
  end

  helper_method :selection_jetty
  def selection_jetty
    @selection_jetty ||= Jetty.all
  end

  helper_method :selection_vessel
  def selection_vessel
    @selection_vessel ||= Vessel.all
  end

  protected

  ["is_manager?", "is_staff?", "is_agent?", "is_user?", "is_agent?"].each do |m|
    define_method m do
      current_user && current_user.send(m)
    end
     helper_method :"#{m}"
  end

  def is_admin?
    is_manager? && is_system_branch?
  end
  helper_method :is_admin?

  def is_manager?
  	current_user && current_user.is_manager?
  end
  helper_method :is_manager?

  def is_staff?
    current_user && current_user.is_staff?
  end
  helper_method :is_staff?

  def is_agent?
    current_user && current_user.is_agent?
  end
  helper_method :is_agent?

  def is_user?
    current_user && current_user.is_user?
  end
  helper_method :is_user?

  def current_branch
    @current_branch ||= current_user.branch
  end
  helper_method :current_branch

  def is_system_branch?
    current_branch && current_branch.id == system_company.try(:branch_id)
  end
  helper_method :is_system_branch?

  def system_company
    @system_company ||= Company.first || Company.create(:name => "Default Company", :register_number => "12345678")
  end
  helper_method :system_company

  def require_system_admin
    unless is_admin?
      flash[:error] = "Only system admin is allowed to access"
      redirect_to "/exception_handler/access_denied"
    end
  end

  def require_manager
    unless is_manager?
      flash[:error] = "Only manager is allowed to access"
      redirect_to "/exception_handler/access_denied"
    end
  end

  def after_sign_in_path_for(resource)
    if is_user?
      orders_url
    elsif is_agent?
      new_order_url
    elsif is_staff?
      new_order_url
    elsif is_manager?
      new_order_url  
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    home_info_url
  end
end
