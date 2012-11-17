class Staff < User
  default_scope where("type_id IN(?)", [UserType::STAFF, UserType::MANAGER])
  has_many :staff_routines
  belongs_to :branch

  def type_name
  	case self.type_id
  	when UserType::STAFF
  	  "Staff"
  	when UserType::MANAGER
  	  "Manager"
  	end
  end
end