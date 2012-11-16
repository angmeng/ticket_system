class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :username, :type_id, :branch_id, :agent_group_id, :address, :phone, :fax, :remark, :active
  
  #attr_accessible :fullname, :username, :email, :password, :password_confirmation, :remember_me, :type_id, :branch_id, :agent_group_id, :address, :phone, :fax, :remark, :active



  def is_manager?
  	self.type_id == UserType::MANAGER
  end

  def is_staff?
  	self.type_id == UserType::STAFF
  end

  def is_agent?
  	self.type_id == UserType::AGENT
  end

  def is_user?
    self.type_id == UserType::STAFF
  end



	protected

    def email_required?
  	  return false
    end
end
