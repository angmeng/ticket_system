class Agents::SessionsController < Devise::SessionsController
  def create
     resource = warden.authenticate!(:scope => :user, :recall => "#{controller_path}#new")
     if is_navigational_format?
       if resource.sign_in_count == 1
         set_flash_message(:notice, :signed_in_first_time)
       else
         set_flash_message(:notice, :signed_in)
       end
     end
     sign_in(resource_name, resource)
     respond_with resource, :location => after_sign_in_path_for(resource)
   end

  def destroy
    redirect_path = new_agent_session_path
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end
end
