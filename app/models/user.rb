class User < ActiveRecord::Base
  #default_scope where("category_id = ?", UserType::USER)
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :username, :category_id, :branch_id, :agent_group_id, :address, :phone, :fax, :remark, :active, :credit
  
  #attr_accessible :fullname, :username, :email, :password, :password_confirmation, :remember_me, :type_id, :branch_id, :agent_group_id, :address, :phone, :fax, :remark, :active
  validates :username, :presence => true, :uniqueness => true
  validates :fullname, :presence => true


  def is_manager?
  	self.category_id == UserType::MANAGER
  end

  def is_staff?
  	self.category_id == UserType::STAFF
  end

  def is_agent?
  	self.category_id == UserType::AGENT
  end

  def is_user?
    self.category_id == UserType::USER
  end



	protected

    def email_required?
  	  return false
    end
end
