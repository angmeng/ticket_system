class SubAgent < User
  default_scope where("category_id = ?", UserType::SUB_AGENT)
  belongs_to :agent_group
  belongs_to :branch
  has_many :topup_credits

  validates :agent_group_id, :branch_id, :presence => true

end