class Agent < User
  default_scope where(:type_id => UserType::AGENT)

  def initialize
  	self.type_id = UserType::AGENT
  end
end