class Agent < User
  default_scope where("category_id = ?", UserType::AGENT)
  belongs_to :agent_group
  belongs_to :branch
  has_many :topup_credits

  validates :agent_group, :branch, :presence => true
  
end