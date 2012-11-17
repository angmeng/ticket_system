class Agent < User
  default_scope where("category_id = ?", UserType::AGENT)
  belongs_to :agent_group
  belongs_to :branch

  validates :agent_group, :branch, :presence => true
  
end