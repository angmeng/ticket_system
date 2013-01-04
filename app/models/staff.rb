class Staff < User
  default_scope where("category_id IN(?)", [UserType::STAFF, UserType::MANAGER])
  has_many :staff_routines
  has_many :topup_credits
  belongs_to :branch

  validates :branch, :presence => true

  def category_name
  	case self.category_id
  	when UserType::STAFF
  	  "Staff"
  	when UserType::MANAGER
  	  "Manager"
  	end
  end
end